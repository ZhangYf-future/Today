import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/constact/constant_string.dart';
import 'package:today/ui/weather/city_manage/city_manage_mvp.dart';
import 'package:today/utils/constant.dart';

///城市管理页面

class CityManageRoute extends StatefulWidget {
  @override
  CityManageState createState() => CityManageState();
}

class CityManageState extends BaseState<CityManageRoute> {
  //presenter
  CityManagePresenter? _presenter;

  //数据库中的数据
  final List<WeatherCityDBBean> _list = [];

  @override
  void initState() {
    super.initState();
    _presenter = CityManagePresenter(this);
    //请求全部城市列表
    _presenter!.getAllCityList();
  }

  //全部城市列表请求成功的回调
  void requestCityListSuccess(List<WeatherCityDBBean> list) {
    this._list.clear();
    this._list.addAll(list);
    this.updatePage();
  }

  //指定城市删除成功
  void deleteCitySuccess() {
    //请求全部城市列表
    _presenter!.getAllCityList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            StringConstant.WEATHER_CITY_MANAGE,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: ListView.builder(
            itemCount: this._list.length,
            itemBuilder: (context, index) => Card(
              color: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Text(this._list[index].address)),

                    //分割线
                    Container(
                      constraints: BoxConstraints.expand(width: 1, height: 50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white10,
                              Colors.white,
                              Colors.white10
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),

                    //删除按钮
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            BoxConstraints.expand(width: 60, height: 50),
                        child: Text(StringConstant.WEATHER_CITY_DELETE),
                      ),
                      //点击删除城市信息
                      onTap: () => this._presenter!.deleteWeatherCity(
                          this._list[index].id!, this._list[index].hfId),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
