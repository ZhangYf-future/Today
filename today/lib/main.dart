import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:today/net/http_dio.dart';
import 'package:today/ui/bill/list/bill_list_route.dart';
import 'package:today/ui/bill/plan/bill_add_plan.dart';
import 'package:today/ui/bill/action/bill_add_route.dart';
import 'package:today/ui/bill/bill_home_route.dart';
import 'package:today/ui/bill/type/type_list_route.dart';
import 'package:today/ui/home/home_route.dart';
import 'package:today/ui/splash_route.dart';
import 'package:today/ui/weather/home/weather_home_route.dart';
import 'package:today/utils/constant.dart';

void main() {
  runApp(MyApp());
  //配置网络信息
  DioUtils.dioConfig();
}

//弹出toast
void showInfo(String msg) {
  Fluttertoast.showToast(msg: msg);
}

//APP入口
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp() {
    //设置高德地图key
    AMapFlutterLocation.setApiKey("	ef93cf1114922c52a43920a2eab08923", "");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        //首页
        RouteNameConstant.HOME_ROUTE: (context) => HomeRoute(),
        //账单首页
        RouteNameConstant.BILL_HOME_ROUTE: (context) => BillHomeRoute(),
        //添加账单页面
        RouteNameConstant.BILL_ADD_ROUTE: (context) => BillAddRoute(),
        //添加账单计划页面
        RouteNameConstant.BILL_ADD_PLAN_ROUTE: (context) => AddBillPlanRoute(),
        //账单类型列表页面
        RouteNameConstant.BILL_TYPE_LIST_ROUTE: (context) =>
            BillTypeListRoute(),
        //账单列表页面
        RouteNameConstant.BILL_LIST_ROUTE: (context) => BillListRouteWidget(),
        //天气首页
        RouteNameConstant.WEATHER_HOME_ROUTE: (context) => WeatherHomeRoute(),
      },
      //启动页为闪屏页
      home: SplashRoute(),
    );
  }
}
