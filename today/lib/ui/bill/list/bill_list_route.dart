import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/bean/bill/bill_bean.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/utils/constant.dart';

///账单列表页面
///这个页面会加在全部的账单数据
class BillListRouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstant.ALL_BILL,
          style: TextStyle(
            color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.filter_alt,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: _ContentWidget(),
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
    );
  }

  //跳转到按月份统计的页面
  void _toPlanListWithMonthRoute() {}
}

class _ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContentState();
}

class _ContentState extends State<_ContentWidget> {
  //数据库中全部的账单列表
  final List<BillBean> _billBeanList = List();

  //数据库帮助类
  final DBHelper _helper = DBHelper();

  @override
  void initState() {
    super.initState();
    _getAllBill();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _billBeanList.length,
            itemBuilder: (context, index) =>
                _BillContentItemWidget(_billBeanList[index]),
          ),
        ),
      ],
    );
  }

  //获取数据库中全部的账单
  void _getAllBill() async {
    this._billBeanList.clear();
    var dbData = await _helper.getAllBillBean();
    this._billBeanList.addAll(dbData.reversed);
    _updatePage();
  }

  //更新页面
  void _updatePage() {
    if (mounted) {
      setState(() {});
    }
  }
}

//显示按照月份和按照类型查询的UI
class _FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          //按照计划月份筛选信息
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.date_range,
                    size: 20.0,
                  ),
                  Text(
                    StringConstant.PLAN_MONTH,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //按照账单类型筛选信息
          Expanded(
              child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.merge_type_sharp,
                  size: 20,
                ),
                Text(
                  StringConstant.BILL_TYPE,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

//列表itemwidget
class _BillContentItemWidget extends StatelessWidget {
  final BillBean _billBean;

  _BillContentItemWidget(this._billBean);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
        bottom: 10.0,
      ),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //第一行显示类型和时间信息
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                //类型信息
                Text(
                  _billBean.billTypeBean.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),

                //右边显示时间信息
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _billBean.timeFormat,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //中间显示金额信息
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                "${_billBean.amount.toString()}元",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            //右下角显示位置信息
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${_billBean.address == null ? StringConstant.NO_ADDRESS : _billBean.address}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
