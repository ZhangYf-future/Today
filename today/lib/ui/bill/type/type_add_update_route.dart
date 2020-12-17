import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/main.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';
import 'package:today/utils/string_utils.dart';

/// 添加或者修改账单类型

class AddOrUpdateTypeRoute extends StatefulWidget {
  //上个页面传递过来的类型信息
  final BillTypeBean _typeBean;

  AddOrUpdateTypeRoute(this._typeBean, {Key key}) : super(key: key);

  @override
  _AddOrUpdateTypeState createState() => _AddOrUpdateTypeState(_typeBean);
}

class _AddOrUpdateTypeState extends State<AddOrUpdateTypeRoute> {
  //账单类型数据
  final BillTypeBean _typeBean;

  //是否可以编辑
  bool _canEdit = false;

  //数据库帮助类
  final DBHelper _dbHelper = DBHelper();

  _AddOrUpdateTypeState(this._typeBean);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _typeBean == null ? StringConstant.ADD_BILL_TYPE : _typeBean.name,
          style: TextStyle(
            color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
            fontSize: 16.0,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              if (_typeBean != null) {
                _canEdit = !_canEdit;
                _updateWidget();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                _typeBean == null ? "" : StringConstant.EDIT,
                style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: _ContentWidget(_typeBean, _canEdit, _insert),
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
    );
  }

  //添加账单类型
  void _insert(BillTypeBean bean) async {
    int result = await _dbHelper.insertABillType(bean);
    if (result > -1) {
      //添加数据成功,将当前数据返回
      Navigator.pop(context, bean);
    }
  }

  //更新widget
  void _updateWidget() {
    if (mounted) {
      setState(() {});
    }
  }
}

//内容部分
class _ContentWidget extends StatelessWidget {
  //需要修改的类型数据
  final BillTypeBean _typeBean;
  //是否可以编辑
  final bool _canEdit;
  //类型名称输入框控制器
  final TextEditingController _typeNameController = TextEditingController();

  //类型备注输入框控制器
  final TextEditingController _typeRemarkController = TextEditingController();

  //点击确认按钮的接口回调
  final Function _insertData;

  //title样式
  final TextStyle _titleStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  _ContentWidget(this._typeBean, this._canEdit, this._insertData);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //说明信息
        Container(
          color: Color.fromARGB(255, 130, 130, 130),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "${StringConstant.DESCRIPTION}: ${StringConstant.DESCRIPTION_ADD_TYPE}",
              style: TextStyle(
                color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                fontSize: 12.0,
              ),
            ),
          ),
        ),

        //类型名称
        Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Text(
            StringConstant.TYPE_NAME,
            style: _titleStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
            controller: _typeNameController,
            decoration: InputDecoration(
              hintText: StringConstant.PLEASE_INPUT_TYPE_NAME,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ),
        ),

        //备注信息
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Text(
            StringConstant.REMARK,
            style: _titleStyle,
          ),
        ),

        //备注信息输入框
        Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: TextField(
            controller: _typeRemarkController,
            decoration: InputDecoration(
              hintText: StringConstant.PLEASE_INPUT_TYPE_REMARK,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ),
        ),

        //确认按钮
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
              child: GestureDetector(
                onTap: () => _confirm(context),
                child: Center(
                  child: Text(
                    StringConstant.CONFIRM,
                    style: TextStyle(
                        color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                        fontSize: 16.0),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //点击确认
  void _confirm(BuildContext context) {
    var name = _typeNameController.text;
    if (StringUtils.isEmpty(name)) {
      showInfo(context, StringConstant.PLEASE_INPUT_TYPE_NAME);
      return;
    }

    var remark = _typeRemarkController.text;

    BillTypeBean bean = BillTypeBean();
    bean.createTime = DateUtils.getCurrentTime();
    bean.name = name;
    bean.remark = remark;
    //通过回调函数添加数据到数据库
    this._insertData(bean);
  }
}
