import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:today/bean/bill/bill_bean.dart';
import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/bean/comm/db_result_bean.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/constact/constant_event.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/event/event_bill.dart';
import 'package:today/main.dart';
import 'package:today/utils/constant.dart';

import 'package:today/utils/date_utils.dart' as date_utils;
import 'package:today/utils/jump_route_utils.dart';

///添加账单页面
class BillAddRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringConstant.NEW_BILL_RECORD,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
      body: _ContentWidget(),
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
    );
  }
}

///内容部分
class _ContentWidget extends StatefulWidget {
  @override
  _ContentState createState() {
    return _ContentState();
  }
}

class _ContentState extends State<_ContentWidget> {
  //数据库帮助类
  final DBHelper _dbHelper = new DBHelper();

  //默认认为当月没有创建消费计划
  BillPlanBean? _thisMonthPlanBean;

  //默认是支出信息
  bool _isPay = true;

  //用户当前选择的账单类型
  BillTypeBean? _chooseBillTypeBean;

  //地址信息输入框控制器
  TextEditingController _addressInputController = TextEditingController();

  //备注信息输入框控制器
  TextEditingController _remarkInputController = TextEditingController();

  //金额信息输入框控制器
  TextEditingController _amountInputController = TextEditingController();

  //最长使用的三个账单类型
  List<BillTypeBean> _billTypeTopThree = List.empty();

  //标题样式
  final TextStyle _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  //内容文本样式
  final TextStyle _contentStyle = TextStyle(
    color: ColorConstant.COLOR_424242,
    fontSize: 16.0,
  );

  @override
  void initState() {
    super.initState();
    //判断当月是否有消费计划
    _checkThisMonthPlan();
    //获取最常使用的账单类型
    _getBillTypeTopThree();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        //上面显示可输入的部分
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //时间和计划信息
                _BillItemWidget(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Text(
                          StringConstant.TIME_AND_PLAN,
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 16.0,
                          ),
                        ),
                      ),

                      //时间信息
                      _TimeWidget(this._titleStyle, this._contentStyle),

                      //计划信息
                      _PlanWidget(_thisMonthPlanBean, this._titleStyle,
                          this._contentStyle),

                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    ],
                  ),
                ),

                //地址和备注
                _BillItemWidget(
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Text(
                            StringConstant.ADDRESS_AND_REMARK,
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        //输入地址信息
                        _InputAddressWidget(_addressInputController,
                            _titleStyle, _contentStyle),

                        //输入备注信息
                        _InputRemarkWidget(
                            _remarkInputController, _titleStyle, _contentStyle),
                      ],
                    ),
                  ),
                  marginTop: 15.0,
                ),

                //账单类型信息
                _BillItemWidget(
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //类型信息
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Text(
                            StringConstant.PAY_TYPE,
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        //是否是支出和账单分类
                        //暂时取消是否为支出信息，默认即为支出，不会保存收入信息
                        // _IsPayWidget(_isPay, this._titleStyle,
                        //     this._contentStyle, _changeIsPay),

                        //选择类型信息
                        _TypeWidget(_chooseBillTypeBean, this._titleStyle,
                            this._contentStyle, _toChooseBillTypeRoute),
                      ],
                    ),
                  ),
                  marginTop: 15.0,
                ),

                //金额输入框
                _BillItemWidget(
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Text(
                            StringConstant.AMOUNT,
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        _InputAmountWidget(_amountInputController, _titleStyle),
                      ],
                    ),
                  ),
                  marginTop: 20.0,
                ),
              ],
            ),
          ),
        ),

        //底部显示创建月度计划或者添加账单的按钮
        GestureDetector(
          onTap:
              //点击跳转到创建计划页面
              _thisMonthPlanBean != null ? _addBillRecord : _toAddPlanRoute,
          child: Container(
            margin: EdgeInsets.all(15.0),
            constraints: BoxConstraints.expand(height: 50.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Text(
              _thisMonthPlanBean != null
                  ? StringConstant.ADD_BILL_RECORD
                  : StringConstant.NO_BILL_PLAN_REMIND,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ),
      ],
    );
  }

  //查看当月是否创建消费计划
  void _checkThisMonthPlan() async {
    _thisMonthPlanBean = await _dbHelper.getCurrentMonthPlan();
    _updatePage();
  }

  //跳转到创建计划页面并获取返回的数据
  void _toAddPlanRoute() async {
    var result = await JumpUtils.toNextRouteWithNameGetResult(
        context, RouteNameConstant.BILL_ADD_PLAN_ROUTE);
    if (result == 1) {
      _checkThisMonthPlan();
    }
  }

  //跳转到选择消费类型页面,需要获取返回的数据
  void _toChooseBillTypeRoute(BuildContext context) async {
    var result = await JumpUtils.toNextRouteWithNameGetResult(
        context, RouteNameConstant.BILL_TYPE_LIST_ROUTE);
    if (result == null) return;
    this._chooseBillTypeBean = result;
    //选择完类型信息后，更新权重信息
    _updateBillTypeWeight();
    _updatePage();
  }

  //添加一条消费记录
  void _addBillRecord() async {
    BillBean bean = BillBean();
    bean.time = DateTime.now().millisecondsSinceEpoch;

    bean.timeFormat = date_utils.DateUtils.getTimeFormat(
        bean.time, date_utils.DateUtils.FORMAT_YYYY_MM_DD_HH_MM);
    bean.isPay = _isPay;
    bean.billTypeBean = _chooseBillTypeBean;
    bean.billPlanBean = this._thisMonthPlanBean;
    bean.address = _addressInputController.text;
    bean.remark = _remarkInputController.text;
    //尝试转换用户输入的数据
    double? inputAmount = double.tryParse(_amountInputController.text);
    double amount = inputAmount == null ? 0 : inputAmount;

    if(amount <= 0){
      showInfo(StringConstant.ERROR_BILL_AMOUNT);
      return;
    }

    bean.amount = amount;

    //添加数据
    DBResultEntity entity = await _dbHelper.insertABill(bean);
    if (entity.code != DBConstant.DB_RESULT_SUCCESS) {
      showInfo(entity.msg);
    } else {
      //调用事件通知机制通知主页添加数据
      billEvent.subscribe(
          EventConstant.EVENT_BILL_CHANGED, BillEvent.BILL_CHANGE_ADD);
      //携带当前数据返回到上个页面
      Navigator.pop(context, bean);
    }
  }

  //修改是否是支出信息
  void _changeIsPay() {
    _isPay = !_isPay;
    _updatePage();
  }

  //获取最常使用的账单类型
  void _getBillTypeTopThree() async {
    this._billTypeTopThree = await _dbHelper.getBillTypeWithWeightTopThree();
    _updatePage();
  }

  //对选择的账单类型的权重加1
  void _updateBillTypeWeight() async {
    var currentWeight = this._chooseBillTypeBean?.weight == null
        ? 0
        : this._chooseBillTypeBean?.weight;
    await _dbHelper.updateBillTypeWeightWithId(
        this._chooseBillTypeBean!.id, currentWeight! + 1);
  }

  //更新页面
  void _updatePage() {
    if (mounted) {
      setState(() {});
    }
  }
}

//时间信息Widget
class _TimeWidget extends StatelessWidget {
  //标题样式
  final TextStyle _titleStyle;

  //内容文本样式
  final TextStyle _contentStyle;

  _TimeWidget(this._titleStyle, this._contentStyle);

  //现在的时间

  final String _current = date_utils.DateUtils.getCurrentTimeWithMinutes();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${StringConstant.TIME}:",
            style: _titleStyle,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                _current,
                style: _contentStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//计划信息Widget
class _PlanWidget extends StatelessWidget {
  //计划信息数据
  final BillPlanBean? _planBean;

  //构造函数传入计划数据
  _PlanWidget(this._planBean, this._titleStyle, this._contentStyle);

  //标题样式
  final TextStyle _titleStyle;

  //内容文本样式
  final TextStyle _contentStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${StringConstant.MONTH_PLAN}:",
            style: _titleStyle,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                _planBean == null
                    ? StringConstant.NO_PLAN_REMIND
                    : "${_planBean!.planYear}年${_planBean!.planMonth}月(${_planBean!.planAmount}元)",
                style: _contentStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//是否是支出Widget
class _IsPayWidget extends StatelessWidget {
  //标题样式
  final TextStyle _titleStyle;

  //内容文本样式
  final TextStyle _contentStyle;

  //是否是支出
  final bool _isPay;

  //点击之后的回调函数
  final Function _clickFunction;

  //构造函数中传入是否是支出
  _IsPayWidget(
      this._isPay, this._titleStyle, this._contentStyle, this._clickFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      child: GestureDetector(
        onTap: () => {_clickFunction()},
        child: Row(
          children: [
            Text(
              "${StringConstant.IS_PAY}:",
              style: _titleStyle,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                color: Colors.transparent,
                child: Text(
                  _isPay
                      ? "${StringConstant.IS}(${StringConstant.CLICK_CHANGE})"
                      : "${StringConstant.NO}(${StringConstant.CLICK_CHANGE})",
                  style: _contentStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//类型信息Widget
class _TypeWidget extends StatelessWidget {
  //标题样式
  final TextStyle _titleStyle;

  //内容文本样式
  final TextStyle _contentStyle;

  //跳转到选择账单类型页面的回调方法
  final Function _toChooseBillTypeFunction;

  //选中的账单类型
  final BillTypeBean? _chooseBillTypeBean;

  _TypeWidget(this._chooseBillTypeBean, this._titleStyle, this._contentStyle,
      this._toChooseBillTypeFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //账单类型
              Text(
                "${StringConstant.BILL_CATEGORY}:",
                style: _titleStyle,
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () => {_toChooseBillTypeFunction(context)},
                  child: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.transparent,
                    child: Text(
                      _chooseBillTypeBean != null
                          ? _chooseBillTypeBean!.name
                          : StringConstant.PLEASE_CHOOSE_BILL_TYPE,
                      style: _contentStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//输入地址信息的widget
class _InputAddressWidget extends StatelessWidget {
  //输入框控制器
  final TextEditingController _controller;

  //标题样式
  final TextStyle _titleStyle;

  //内容样式
  final TextStyle _contentStyle;

  //通过构造函数传递参数
  _InputAddressWidget(this._controller, this._titleStyle, this._contentStyle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
      child: Row(
        children: [
          Text(
            "${StringConstant.ADDRESS}:",
            style: _titleStyle,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _controller,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: _contentStyle,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: StringConstant.INPUT_ADDRESS,
                  hintStyle: _contentStyle,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//输入备注信息的widget
class _InputRemarkWidget extends StatelessWidget {
  //输入框控制器
  final TextEditingController _controller;

  //标题样式
  final TextStyle _titleStyle;

  //内容样式
  final TextStyle _contentStyle;

  _InputRemarkWidget(this._controller, this._titleStyle, this._contentStyle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      child: Row(
        children: [
          Text(
            "${StringConstant.REMARK}:",
            style: _titleStyle,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _controller,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: _contentStyle,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: StringConstant.INPUT_REMARK,
                  hintStyle: _contentStyle,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//输入金额的Widget
class _InputAmountWidget extends StatelessWidget {
  //输入框控制器
  final TextEditingController _controller;

  //标题样式
  final TextStyle _titleStyle;

  //内容样式
  final TextStyle _contentStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.redAccent,
  );

  //提醒文本样式
  final TextStyle _hintTextStyle = TextStyle(
    fontSize: 18.0,
    color: ColorConstant.COLOR_424242,
  );

  _InputAmountWidget(this._controller, this._titleStyle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: _contentStyle,
        maxLines: 1,
        textAlign: TextAlign.start,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("^[0-9]*(?:\.[0-9]*)?\$")),
          LengthLimitingTextInputFormatter(10)
        ],
        decoration: InputDecoration(
          hintText: StringConstant.PLEASE_INPUT_PAY_AMOUNT,
          hintStyle: _hintTextStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

//添加消费记录每一项的信息
class _BillItemWidget extends StatelessWidget {
  final Widget _child;
  double _marginTop = 10.0;

  _BillItemWidget(this._child, {double? marginTop}) {
    if (marginTop != null) this._marginTop = marginTop;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10.0,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.only(
        top: _marginTop,
        left: 15.0,
        right: 15.0,
      ),
      child: _child,
    );
  }
}
