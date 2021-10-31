import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:today/base/base_view.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/ui/weather/city_add/city_add_mvp.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/log_utils.dart';
import 'package:today/utils/string_utils.dart';

///添加城市页面
class CityAddWidget extends StatefulWidget {
  @override
  CityAddState createState() => CityAddState();
}

class CityAddState extends BaseState<CityAddWidget> {
  //城市输入框的controller
  final TextEditingController _inputCityController = TextEditingController();
  //城市输入框的Node
  final FocusNode _inputCityFocusNode = FocusNode();
  //presenter
  CityAddPresenter? _presenter;

  CityAddState(){
    _presenter = CityAddPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            //输入要添加的城市的数据框
            Container(
              constraints: BoxConstraints.expand(height: 35.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Stack(
                alignment: Alignment.centerRight,
                fit: StackFit.expand,
                children: [
                  //输入框
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextField(
                      controller: _inputCityController,
                      maxLines: 1,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                          hintText: StringConstant.INPUT_SEARCH_CITY_NAME,
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 0, bottom: 0),
                          border: InputBorder.none,
                          isCollapsed: true),
                      showCursor: true,
                      onChanged: (str){
                        if(StringUtils.isNotEmpty(str)){
                          //参数不为空，请求数据
                          _presenter!.queryCityList(str);
                        }
                      },
                    ),
                  ),

                  //清除输入内容的按钮
                  Positioned(
                    right: 10,
                    child: GestureDetector(
                      child: Container(
                        //constraints: BoxConstraints.expand(width: 30, height: 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      onTap: (){
                        //清空输入框中的数据
                        _inputCityController.text = "";
                      },
                    ),
                  ),
                
                  //列表

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Logs.ez("退出添加城市页面");
  }
}
