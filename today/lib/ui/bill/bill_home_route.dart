import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/bean/bill/bill_bean.dart';
import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';
import 'package:today/utils/string_utils.dart';

///账单首页
class BillHomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringConstant.MY_BILL,
          style: TextStyle(
              color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR, fontSize: 18.0),
        ),
      ),
      body: _ContentWidget(),
    );
  }
}

//内容部分
class _ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContentState();
  }
}

class _ContentState extends State<_ContentWidget> {
  //数据库帮助类
  DBHelper _helper = DBHelper();

  //当前月份的月度计划信息
  BillPlanBean _monthPlanBean;

  //本月消费金额
  double _consumeAmount = -1;

  //本月计划消费金额
  double _consumePlan = -1;

  //本月剩余可用的消费金额
  double _consumeSurplus = -1;

  //本月剩余消费金额

  //本地数据库中保存的账单列表信息
  final List<BillBean> _billBeanList = List();

  //列表滚动控制器
  final ScrollController _controller = ScrollController();

  //没有数据时显示的内容
  final Container _noDataRemindWidget = Container(
    constraints: BoxConstraints.expand(),
    alignment: Alignment.center,
    child: Text(
      StringConstant.NO_BILL_RECORD,
      style: TextStyle(
        color: Colors.orangeAccent,
        fontSize: 18.0,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    //获取当前月份的账单计划信息
    _getMonthPlanInfo();
    _getAllBill();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            //顶部显示统计信息
            _StatisticsWidget(
              _consumeAmount >= 0 ? _consumeAmount.toString() : "",
              _consumePlan >= 0 ? _consumePlan.toString() : "",
              _consumeSurplus >= 0 ? _consumeSurplus.toString() : "",
            ),

            Expanded(
              child: (!_haveBillData())
                  ? _noDataRemindWidget
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //最近账单文本和查看全部文本
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Text(
                                StringConstant.RECENTLY_BILL,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        StringConstant.WATCH_ALL,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  onTap: () => {
                                    //跳转到账单列表页面
                                    JumpUtils.toNextRouteWithName(context,
                                        RouteNameConstant.BILL_LIST_ROUTE)
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        //下面是一个ListView显示当月账单列表
                        Expanded(
                          child: ListView.builder(
                            controller: _controller,
                            itemCount: _billBeanList.length,
                            itemBuilder: (context, index) => _BillItemWidget(
                                _billBeanList[index],
                                index == _billBeanList.length - 1),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Card(
              color: Colors.blueAccent,
              shadowColor: Colors.grey,
              elevation: 10.0,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.add,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () async {
              //跳转到添加账单的页面
              var result = await JumpUtils.toNextRouteWithNameGetResult(
                  context, RouteNameConstant.BILL_ADD_ROUTE);
              _updateDataWhenAddBillBack(result);
            },
          ),
        ),
      ],
    );
  }

  //获取当前月份的账单计划信息
  void _getMonthPlanInfo() async {
    _monthPlanBean = await _helper.getCurrentMonthPlan();
    if (_monthPlanBean != null) {
      //计划消费金额
      this._consumePlan = _monthPlanBean.planAmount;
      //获取当前消费计划下的账单金额信息
      var amountList =
          await _helper.getAllBillAmountWithPlanId(_monthPlanBean.id);
      if (amountList != null && amountList.isNotEmpty) {
        double totalAmount = 0;
        amountList.forEach((element) {
          totalAmount += element;
        });
        this._consumeAmount = totalAmount;
      }
      //用计划金额减去已经消费的金额即为可用金额
      this._consumeSurplus = _monthPlanBean.planAmount - this._consumeAmount;
    }
    //更新页面
    _updatePage();
  }

  //获取全部的账单信息
  void _getAllBill() async {
    //清空列表中的数据
    _billBeanList.clear();
    //获取账单列表的最近十条数据
    var list = await _helper.getBillLastTenRows();
    _billBeanList.addAll(list);
    _updatePage();
  }

  //添加账单页面返回数据后更新当前页面的数据
  void _updateDataWhenAddBillBack(dynamic result) {
    if (result != null && result is BillBean) {
      //将当前的数据加入到列表中
      this._billBeanList.insert(0, result);
      if (this._billBeanList.length > 10) {
        this._billBeanList.removeRange(10, this._billBeanList.length);
      }

      //如果添加的数据在当前的月度计划中，则更新月度计划数据
      if (this._monthPlanBean != null &&
          result.billPlanBean.id == this._monthPlanBean.id &&
          result.isPay) {
        //添加本月消费金额
        this._consumeAmount = this._consumeAmount >= 0
            ? this._consumeAmount + result.amount
            : result.amount;
        //计算本月剩余可用金额
        this._consumeSurplus =
            this._monthPlanBean.planAmount - this._consumeAmount;
      }
    }
    //更新页面
    _updatePage();
    //滚动到最顶部
    if (this._billBeanList.length > 1) {
      _controller.jumpTo(0);
    }
  }

  //判断是否有账单数据
  bool _haveBillData() {
    return this._billBeanList != null && this._billBeanList.isNotEmpty;
  }

  //更新页面
  void _updatePage() {
    if (mounted) {
      setState(() {});
    }
  }
}

//统计账单信息的部分
class _StatisticsWidget extends StatelessWidget {
  //本月已经消费的金额
  final String _consumeAmount;
  //本月计划消费金额
  final String _consumePlan;
  //剩余可用金额
  final String _consumeSurplus;

  _StatisticsWidget(
      this._consumeAmount, this._consumePlan, this._consumeSurplus);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Expanded(child: Text("本月消费")),
            //Expanded(child: Text("本月计划消费")),

            //第一行显示本月消费信息
            Row(
              children: [
                Text(
                  "本月消费",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                          text:
                              "${StringUtils.isEmpty(_consumeAmount) ? '--' : _consumeAmount}",
                          children: [
                            TextSpan(
                              text: " 元",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            )
                          ]),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),

            //第二行显示本月计划消费
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  Text(
                    "本月计划消费",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text.rich(
                        TextSpan(
                            text:
                                "${StringUtils.isEmpty(_consumePlan) ? '--' : _consumePlan}",
                            children: [
                              TextSpan(
                                text: " 元",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              )
                            ]),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //第三行显示本月剩余可用金额
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  Text(
                    "本月剩余可用",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text.rich(
                        TextSpan(
                            text:
                                "${StringUtils.isEmpty(_consumeSurplus) ? '--' : _consumeSurplus}",
                            children: [
                              TextSpan(
                                text: " 元",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              )
                            ]),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//每一个账单信息item
class _BillItemWidget extends StatelessWidget {
  final BillBean _billBean;

  final bool _isLast;

  _BillItemWidget(this._billBean, this._isLast);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10.0,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin:
          EdgeInsets.only(left: 15.0, right: 15.0, bottom: _isLast ? 20.0 : 10),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //第一行
            Row(
              children: [
                //左边显示消费名称
                Text(_billBean.billTypeBean.name),
                //右边显示时间
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(_billBean.timeFormat),
                  ),
                )
              ],
            ),

            //中间显示消费了多少钱
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '${_billBean.isPay ? "-" : "+"}${_billBean.amount}元',
                style: TextStyle(
                  color:
                      _billBean.isPay ? Colors.redAccent : Colors.greenAccent,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            //底部左边显示计划信息，右边显示地址信息
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //所属计划信息
                  Text(
                    "所属计划:  ${_billBean.billPlanBean.planYear}-${_billBean.billPlanBean.planMonth}",
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 14.0,
                    ),
                  ),

                  //右边显示位置信息
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        StringUtils.isEmpty(_billBean.address)
                            ? "暂无位置信息"
                            : _billBean.address,
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
