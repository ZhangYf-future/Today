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
      floatingActionButton: GestureDetector(
        child: Card(
          color: Colors.blueAccent,
          shadowColor: Colors.grey,
          elevation: 5.0,
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
        onTap: () => {
          //跳转到添加账单的页面
          JumpUtils.toNextRouteWithNameGetResult(
              context, RouteNameConstant.BILL_ADD_ROUTE)
        },
      ),
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

  //本月消费金额
  double _consumeAmount = -1;

  //本月计划消费金额
  double _consumePlan = -1;

  //本月剩余可用的消费金额
  double _consumeSurplus = -1;

  //本月剩余消费金额

  //本地数据库中保存的账单列表信息
  final List<BillBean> _billBeanList = List();

  @override
  void initState() {
    super.initState();
    _getAllBill();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //顶部显示统计信息
        _StatisticsWidget(
          _consumeAmount >= 0 ? _consumeAmount.toString() : "",
          _consumePlan >= 0 ? _consumePlan.toString() : "",
          _consumeSurplus >= 0 ? _consumeSurplus.toString() : "",
        ),
        //下面是一个ListView显示当月账单列表
        Expanded(
            child: ListView.builder(
                itemCount: _billBeanList.length,
                itemBuilder: (context, index) => _BillItemWidget(
                    _billBeanList[index], index == _billBeanList.length - 1))),
      ],
    );
  }

  //获取当前月份的账单计划信息
  void _getMonthPlanInfo() async {
    BillPlanBean planBean = await _helper.getCurrentMonthPlan();
    if (planBean != null) {
      this._consumePlan = planBean.planAmount;
    }
  }

  //获取全部的账单信息
  void _getAllBill() async {
    //首先获取当前月份的账单计划信息
    _getMonthPlanInfo();
    //清空列表中的数据
    _billBeanList.clear();
    //获取到全部的账单信息
    var list = await _helper.getAllBillBean();
    _billBeanList.addAll(list.reversed);
    //遍历列表，获取已经消费的数据
    double total = 0;
    for (BillBean item in _billBeanList) {
      if (item.isPay) {
        total += item.amount;
      }
    }

    this._consumeAmount = total;
    if (this._consumePlan >= 0 && this._consumeAmount >= 0) {
      this._consumeSurplus = this._consumePlan - this._consumeAmount;
    }
    _updatePage();
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
      margin: EdgeInsets.only(
          top: 10.0, left: 15.0, right: 15.0, bottom: _isLast ? 20.0 : 0),
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
