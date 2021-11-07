import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
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
  //请求到的城市信息
  WeatherCityListBean? _weatherCityList;
  //presenter
  CityAddPresenter? _presenter;

  //创建presenter
  CityAddState() {
    _presenter = CityAddPresenter(this);
  }

  //城市信息请求成功后的回调
  void requestCityListSuccess(WeatherCityListBean weatherCityListBean) {
    this._weatherCityList = weatherCityListBean;
    updatePage();
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
              constraints: BoxConstraints.expand(height: 45.0),
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
                  TextField(
                    controller: _inputCityController,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                        filled: true,
                        hintText: StringConstant.INPUT_SEARCH_CITY_NAME,
                        contentPadding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 0, bottom: 0),
                        border: InputBorder.none,
                        isCollapsed: false),
                    showCursor: true,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (input) => _presenter!.queryCityList(input),
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
                      onTap: () {
                        //清空输入框中的数据
                        _inputCityController.text = "";
                        _weatherCityList = null;
                        _presenter!.clearOldName();
                        updatePage();
                      },
                    ),
                  ),
                ],
              ),
            ),

            //列表
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (_weatherCityList == null) {
                    return Container();
                  }
                  var list = _weatherCityList!.location;
                  if (list == null) {
                    return Container();
                  }
                  var entity = list[index];
                  if (entity == null) {
                    return Container();
                  }
                  return GestureDetector(
                    child: _CityWidget(entity),
                    onTap: () => this._presenter!.insertCityBean(entity),
                  );
                },
                itemCount: _weatherCityList == null ||
                        _weatherCityList!.location == null
                    ? 0
                    : _weatherCityList!.location!.length,
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

///城市信息widget
class _CityWidget extends StatelessWidget {
  final WeatherCityBean _cityBean;

  _CityWidget(this._cityBean);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        //constraints: BoxConstraints.expand(height: 40.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                  "${_cityBean.adm1} ${_cityBean.adm2}市${_cityBean.name}区(县)"),
            ),
            Text(_cityBean.country),
          ],
        ),
      ),
    );
  }
}
