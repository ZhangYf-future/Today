import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/constact/constant_string.dart';
import 'package:today/ui/weather/city_add/city_add_mvp.dart';
import 'package:today/utils/log_utils.dart';

///添加城市页面
class CityAddWidget extends StatefulWidget {
  @override
  CityAddState createState() => CityAddState();
}

class CityAddState extends BaseState<CityAddWidget> {
  //创建presenter
  CityAddState() {
    _presenter = CityAddPresenter(this);
  }

  //城市输入框的controller
  final TextEditingController _inputCityController = TextEditingController();
  //城市输入框的FocusNode
  final FocusNode _inputCityFocusNode = FocusNode();

  //presenter
  CityAddPresenter? _presenter;

  //请求到的城市信息
  WeatherCityListBean? _weatherCityList;

  @override
  void initState() {
    super.initState();
    _inputCityFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    Logs.ez("退出添加城市页面");
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
              constraints: BoxConstraints.expand(height: 40.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //返回键
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      constraints: BoxConstraints.expand(width: 40.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  Expanded(
                    flex: 1,
                    //文本输入框
                    child: TextField(
                      controller: _inputCityController,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          isDense: true,
                          filled: true,
                          hintText: StringConstant.INPUT_SEARCH_CITY_NAME,
                          contentPadding: EdgeInsets.only(right: 10.0),
                          border: InputBorder.none,
                          isCollapsed: false),
                      showCursor: true,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (input) => _presenter!.queryCityList(input),
                      focusNode: _inputCityFocusNode,
                    ),
                  ),

                  Container(
                    constraints: BoxConstraints.expand(width: 1.0),
                    color: Colors.black45,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                  ),

                  //搜索按钮
                  Container(
                    child: MaterialButton(
                      onPressed: () =>
                          _presenter!.queryCityList(_inputCityController.text),
                      child: Text("搜索"),
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
}

///城市信息widget
class _CityWidget extends StatelessWidget {
  _CityWidget(this._cityBean);

  final WeatherCityBean _cityBean;

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
