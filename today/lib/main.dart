import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:today/ui/bill/bill_add_plan.dart';
import 'package:today/ui/bill/bill_add_route.dart';
import 'package:today/ui/bill/bill_home_route.dart';
import 'package:today/ui/bill/type/type_list_route.dart';
import 'package:today/ui/home_route.dart';
import 'package:today/ui/splash_route.dart';
import 'package:today/utils/constant.dart';

void main() {
  runApp(MyApp());
}

//弹出toast
void showInfo(BuildContext context, String msg) {
  Toast.show(msg, context, duration: 2);
}

//APP入口
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      },
      home: SplashRoute(),
    );
  }
}
