import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/event/event_weather.dart';
import 'package:today/ui/weather/home/weather_home_mvp.dart';
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
  final PageController _pageController = PageController(initialPage: 2);

  //页面列表
  final List<WeatherCityDBBean> _pageList = <WeatherCityDBBean>[];

  //presenter
  WeatherHomePresenter? _presenter;

  WeatherHomeState(){
    _presenter = WeatherHomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    weatherCityEvent.addCityRepeatAddedEvent((bean) {
      Logs.ez("城市被重复添加");
      _pageController.jumpToPage(0);
    });

    weatherCityEvent.addCityAddedEvent((bean) {
      Logs.ez("城市被添加");
      _pageList.add(WeatherCityDBBean.fromOther(bean));
      updatePage();
    });

    //请求全部的城市信息
    getAllCityList();
    //_presenter!.initState();
    //请求地理位置信息
    _presenter!.getLocation();

  }

  //请求本地保存的城市列表信息
  void getAllCityList() async{
    final list = await _presenter!.getAllCityList();
    _pageList.addAll(list);
    updatePage();
  }

  //位置信息请求成功之后的回调
  void getLocationSuccess(WeatherCityDBBean dbBean){
    Logs.ez("请求百度地图定位成功:${dbBean.name}");
    _pageList.insert(0, dbBean);
    updatePage();
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
            child: PageView(
              controller: _pageController,
              children:
                  _pageList.map((e) => _WeatherInfoWidget(e)).toList(),
            ),
          ),

          //页面底部是当前的指示器
        ],
      ),
      backgroundColor: Colors.blueAccent,
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

///页面UI
class _WeatherInfoWidget extends StatefulWidget {
  //城市信息，可能是经纬度信息，也可能是城市id
  final WeatherCityDBBean _cityInfo;

  _WeatherInfoWidget(this._cityInfo);

  @override
  WeatherInfoState createState() => WeatherInfoState();
}

class WeatherInfoState extends BaseState<_WeatherInfoWidget> {
  @override
  Widget build(BuildContext context) => RefreshIndicator(
      displacement: 40.0,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              //实时天气部分
              Card(
                elevation: 10.0,
                color: Colors.white,
                child: Container(
                  constraints: BoxConstraints.expand(height: 50.0),
                  child: Text(widget._cityInfo.address),
                ),
              ),
            ],
          ),
        ),
      ),
      onRefresh: () async {
        return Future.delayed(Duration(seconds: 3));
      });
}
