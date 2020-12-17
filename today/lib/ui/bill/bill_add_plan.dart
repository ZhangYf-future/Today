import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';

///添加账单计划的页面

class AddBillPlanRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstant.ADD_BILL_PLAN,
          style: TextStyle(
              color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR, fontSize: 16.0),
        ),
        centerTitle: true,
      ),
      body: _ContentWidget(),
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
    );
  }
}

class _ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContentState();
  }
}

class _ContentState extends State<_ContentWidget> {
  //标题部分的文本样式
  final _titleTextStyle = TextStyle(
    color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
    fontSize: 16.0,
  );

  //数据库帮助类
  final DBHelper _dbHelper = DBHelper();

  //当前年份
  int _year;

  //当前月份
  int _month;

  //用户输入计划金额的controller
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getYearMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //计划年度
            //使用默认的年度信息
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "${StringConstant.PLAN_YEAR}:",
                    style: _titleTextStyle,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "${_year.toString()}年",
                        style: _titleTextStyle,
                      ),
                    ),
                  )
                ],
              ),
            ),

            //使用默认的月度信息
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "${StringConstant.PLAN_MONTH}:",
                    style: _titleTextStyle,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "${_month.toString()}月",
                        style: _titleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //提醒用户输入计划金额
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Text(
                "${StringConstant.PLAN_PAY_AMOUNT}:",
                style: _titleTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                controller: _amountController,
                style: TextStyle(
                  color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                  fontSize: 14.0,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp("^[0-9]*(?:\.[0-9]*)?\$"))
                ],
                maxLines: 1,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: StringConstant.INPUT_PLAN_PAY_AMOUNT,
                ),
              ),
            ),
          ],
        ),
      ),
      //点击确认的按钮
      Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: ElevatedButton(
            onPressed: _insertPlanData,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Text(
                  StringConstant.CONFIRM,
                  style: _titleTextStyle,
                ),
              ),
            )),
      ),
    ]);
  }

  //获取当前月份和年份
  void _getYearMonth() {
    _year = DateUtils.getCurrentYear();
    _month = DateUtils.getCurrentMonth();
    _updatePage();
  }

  //将用户输入的信息添加到数据表中
  void _insertPlanData() async {
    var bean = BillPlanBean();
    bean.planAmount = double.parse(_amountController.text);
    bean.planYear = _year;
    bean.planMonth = _month;
    var result = await _dbHelper.insertBillPlan(bean);
    if (result == StringConstant.INSERT_DATA_SUCCESS) {
      //退出当前页面并返回1表示成功
      Navigator.pop(context, 1);
    }
  }

  //更新页面
  void _updatePage() {
    if (mounted) {
      setState(() {});
    }
  }
}
