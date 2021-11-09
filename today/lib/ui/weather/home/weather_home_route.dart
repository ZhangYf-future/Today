import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/event/event_weather.dart';
import 'package:today/ui/weather/home/weather_home_mvp.dart';
import 'package:today/ui/weather/home/weather_info_widget.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';
import 'package:today/utils/log_utils.dart';

///天气首页
class WeatherHomeRoute extends StatefulWidget {
  @override
  WeatherHomeState createState() => WeatherHomeState();
}

class WeatherHomeState extends BaseState<WeatherHomeRoute> {
  //页面控制
  final PageController _pageController = PageController(keepPage: true);

  //页面列表
  final List<WeatherCityDBBean> _pageList = <WeatherCityDBBean>[];

  //presenter
  WeatherHomePresenter? _presenter;

  WeatherHomeState() {
    _presenter = WeatherHomePresenter(this);
    weatherCityEvent.addCityRepeatAddedEvent((bean) {
      Logs.ez("城市被重复添加");
      _pageController.jumpToPage(0);
    });

    weatherCityEvent.addCityAddedEvent((bean) {
      Logs.ez("城市被添加");
      _pageList.add(WeatherCityDBBean.fromOther(bean));
      updatePage();
    });
  }

  @override
  void initState() {
    super.initState();

    //请求地理位置信息
    _presenter!.getLocation();
  }

  //请求本地保存的城市列表信息
  void getAllCityList() async {
    final list = await _presenter!.getAllCityList();
    _pageList.addAll(list);
    updatePage();
  }

  //位置信息请求成功之后的回调
  void getLocationSuccess(WeatherCityDBBean dbBean) {
    Logs.ez("请求百度地图定位成功:${dbBean.name}");
    _pageList.insert(0, dbBean);
    //请求全部的城市信息
    getAllCityList();
  }

  //位置信息请求失败的回调
  void getLocationFailed() {
    //请求全部的城市信息
    getAllCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //页面中间是显示当前天气信息的Widget
          Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: this._pageList.isEmpty
                ? null
                : PageView.builder(
                  itemCount: this._pageList.length,
                    itemBuilder: (context, index) =>
                        WeatherInfoWidget(_pageList[index]),
                    controller: this._pageController,
                  ),
          ),

          //页面底部是当前的指示器
        ],
      ),
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
      floatingActionButton: GestureDetector(
        child: Container(
          constraints: BoxConstraints.expand(width: 50.0, height: 50.0),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onTap: () => JumpUtils.toNextRouteWithName(
            context, RouteNameConstant.WEATHER_ADD_CITY_ROUTE),
      ),
    );
  }
}
