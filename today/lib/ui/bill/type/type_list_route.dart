import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/constact/constant_string.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/ui/bill/type/type_add_update_route.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///账单类型列表页面
class BillTypeListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstant.BILL_TYPE_LIST,
          style: TextStyle(
            color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
      body: _ContentWidget(),
    );
  }
}

//内容部分
class _ContentWidget extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_ContentWidget> {
  //全部的账单类型列表
  List<BillTypeBean> _list = List.empty(growable: true);

  //数据库帮助类
  final DBHelper _dbHelper = DBHelper();

  //数据库中没有数据的提示的Widget
  final Widget _noDataWidget = SizedBox(
    width: 300,
    height: 100,
    child: Text(
      StringConstant.BILL_TYPE_LIST_NO_DATA,
      style: TextStyle(
        color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
        fontSize: 14.0,
      ),
      textAlign: TextAlign.center,
    ),
  );

  @override
  void initState() {
    super.initState();
    _getAllBillType();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          alignment: Alignment.center,
          child: _list.isEmpty
              ? _noDataWidget
              : ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, position) =>
                      _BillTypeItemWidget(_list[position], _toAddUpdateRoute)),
        ),
        //右下角显示添加按钮
        Positioned(
          right: 10,
          bottom: 20,
          child: Card(
            color: Colors.blueAccent,
            shadowColor: Colors.grey,
            elevation: 5.0,
            shape: CircleBorder(),
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.add,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => _toAddUpdateRoute(null),
            ),
          ),
        ),
      ],
    );
  }

  //跳转到添加或者更新账单类型页面
  void _toAddUpdateRoute(BillTypeBean? bean) async {
    await JumpUtils.toNextRouteGetResult(context, AddOrUpdateTypeRoute(bean));
    _getAllBillType();
  }

  //获取数据库中全部的账单类型
  void _getAllBillType() async {
    _list.clear();
    _list.addAll(await _dbHelper.getAllBillType());
    _updateWidget();
  }

  //更新widget
  void _updateWidget() {
    if (mounted) {
      setState(() {});
    }
  }
}

//账单类型列表widget
class _BillTypeItemWidget extends StatelessWidget {
  final BillTypeBean _typeBean;

  final Function _clickEditFun;

  _BillTypeItemWidget(this._typeBean, this._clickEditFun);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          shadowColor: Colors.grey,
          elevation: 10.0,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    //名称
                    Expanded(
                      child: Text(
                        _typeBean.name,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),

                    //时间
                    Expanded(
                      child: Text(
                        _typeBean.createTime,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),

                //备注信息
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(_typeBean.remark),
                ),

                //编辑按钮
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //左边显示编辑文本
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 2.0),
                          child: Text(StringConstant.EDIT),
                        ),

                        //右边显示编辑图标
                        Icon(
                          Icons.arrow_right_sharp,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => {this._clickEditFun(_typeBean)},
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          //将当前选中的账单类型返回到上个页面
          Navigator.pop(context, _typeBean);
        },
      ),
    );
  }
}
