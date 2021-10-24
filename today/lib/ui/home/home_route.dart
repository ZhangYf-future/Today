import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/ui/home/home_block_bill.dart';
import 'package:today/ui/home/home_block_weather.dart';
import 'package:today/ui/home/home_route_mvp.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/log_utils.dart';

///首页路由
class HomeRoute extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

///首页页面信息
class HomeState extends BaseState<HomeRoute> {
  //需要显示的数据信息
  final List<HomeBlockBean> _homeBlockList = List.empty(growable: true);
  //页面逻辑操作
  HomeRoutePresenter? _presenter;
  //天气信息
  WeatherNowBean? _weatherNowBean;
  //今天已经消费的数据
  double? _todayAmount;

  //构造函数
  HomeState() {
    _presenter = HomeRoutePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    //加载页面中应该显示的block
    _loadBlocks();
    //加载实时天气信息
    _loadNowWeather();
    //加载进入消费金额信息
    _loadTodayBillCount();
  }

  //加载页面block
  void _loadBlocks() {
    _homeBlockList.clear();
    _homeBlockList.addAll(_presenter!.getHomeBlocks());
    updatePage();
  }

  //获取当前实时天气信息
  void _loadNowWeather() async {
    _weatherNowBean = await _presenter!.getNowWeather();
    updatePage();
  }

  //获取今天的消费金额
  void _loadTodayBillCount() async {
    _todayAmount = await _presenter!.getBillCountToday();
    Logs.ez("今日账单:$_todayAmount");
    updatePage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Scaffold(
          backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
          endDrawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: 50.0,
          //标题栏
          appBar: AppBar(
            title: Text(
              StringConstant.MY_DAY,
              style: TextStyle(
                color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                fontSize: 20.0,
              ),
            ),
            centerTitle: true,
          ),

          //内容区
          body: Container(
            constraints: BoxConstraints.expand(),
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, position) {
                switch (this._homeBlockList[position].type) {
                  //账单
                  case HomeBlockConstant.HOME_BLOCK_TYPE_BILL:
                    return HomeBillBlockWidget(
                        this._homeBlockList[position], _todayAmount);
                  //天气
                  case HomeBlockConstant.HOME_BLOCK_TYPE_WEATHER:
                    return HomeBlockWeatherWidget(
                        this._homeBlockList[position], _weatherNowBean?.now);
                  //默认返回null
                  default:
                    return Spacer();
                }
              },
              itemCount: _homeBlockList.length,
            ),
          ),
        ));
  }
}

/// 不是第一个block块的Widget
class _MyDayFunctionBlockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        child: Center(
          child: Text("function widget"),
        ),
      ),
    );
  }
}
