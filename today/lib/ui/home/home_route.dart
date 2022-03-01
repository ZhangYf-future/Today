import 'dart:io';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/constact/constant_event.dart';
import 'package:today/event/event_bill.dart';
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
    //监听账单数据的变化
    _subscribeBillChange();
    //加载页面中应该显示的block
    _loadBlocks();
    //显示隐私协议的dialog
    _showPrivacyDialog(context);
  }

  //监听账单数据的变化
  void _subscribeBillChange() {
    billEvent.addObserver(EventConstant.EVENT_BILL_CHANGED, (type) {
      //数据变化之后重新调用数据库查询方法
      if (type == BillEvent.BILL_CHANGE_ADD ||
          type == BillEvent.BILL_CHANGE_DELETE) {
        _loadTodayBillCount();
      }
    });
  }

  //加载页面block
  void _loadBlocks() {
    _homeBlockList.clear();
    _homeBlockList.addAll(_presenter!.getHomeBlocks());
    updatePage();
  }

  //获取当前实时天气信息
  void _loadNowWeather() async {
    _presenter!.getNowWeather();
  }

  //实时天气获取完成后的回调
  void loadNowWeatherSuccess(WeatherNowBean bean) {
    this._weatherNowBean = bean;
    updatePage();
  }

  //获取今天的消费金额
  void _loadTodayBillCount() async {
    _todayAmount = await _presenter!.getBillCountToday();
    Logs.ez("今日账单:$_todayAmount");
    updatePage();
  }

  //显示隐私提示的弹框
  void _showPrivacyDialog(BuildContext context) async {
    final showed = await this._presenter!.checkShowedPravicyDialog();
    if (!showed) {
      //没有显示过，首先显示dialog
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => WillPopScope(
          child: SimpleDialog(
            title: Align(
              child: Text(StringConstant.PRIVACY_AGREEMENT),
              alignment: Alignment.topCenter,
            ),
            children: [
              Container(
                child: Text(
                  StringConstant.PRIVACY_AGREEMENT_CONTENT,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
              ),
              TextButton(
                  onPressed: () {
                    this._presenter!.setShowedPrivacyAgreement();
                    Navigator.pop(context);
                  },
                  child: Text(StringConstant.I_KNOW)),
            ],
          ),
          onWillPop: () => exit(0),
        ),
      );
    }
    //加载实时天气信息
    _loadNowWeather();
    //加载今日消费金额信息
    _loadTodayBillCount();
  }

  @override
  void dispose() {
    super.dispose();
    Logs.ez("dispose...");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: 50.0,
          //标题栏
          appBar: AppBar(
            title: Text(
              StringConstant.MY_DAY,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),

          //内容区
          body: Container(
            constraints: BoxConstraints.expand(),
            child: ListView.builder(
              itemBuilder: (context, position) {
                switch (this._homeBlockList[position].type) {
                  //账单
                  case HomeBlockConstant.HOME_BLOCK_TYPE_BILL:
                    return HomeBillBlockWidget(
                        this._homeBlockList[position], _todayAmount);
                  //天气
                  case HomeBlockConstant.HOME_BLOCK_TYPE_WEATHER:
                    return HomeBlockWeatherWidget(
                        this._homeBlockList[position], _weatherNowBean);
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
