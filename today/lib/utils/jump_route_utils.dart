import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/utils/string_utils.dart';

/// 页面跳转的工具类
class JumpUtils {
  //默认的页面跳转调用的方法
  static void toNextRoute(BuildContext context, Widget nextRoute) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextRoute));
  }

  //如果需要接收路由的返回值则调用这个方法
  static dynamic toNextRouteGetResult<T extends Object>(
      BuildContext context, Widget nextRoute) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => nextRoute));
    return result;
  }

  //跳转到新的页面并结束当前页面
  static void toNextRouteAndFinish(BuildContext context, Widget nextRoute) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => nextRoute), (route) => false);
  }

  //根据传入的新页面的名字进行跳转
  static void toNextRouteWithName(BuildContext context, String routeName) {
    if (StringUtils.isEmpty(routeName)) throw Exception("路由名称不能为空，请检查");
    Navigator.pushNamed(context, routeName);
  }

  //根据传入的新页面的名字进行跳转，并接收返回的参数
  static dynamic toNextRouteWithNameGetResult(
      BuildContext context, String routeName) async {
    if (StringUtils.isEmpty(routeName)) throw Exception("路由名称不能为空，请检查");
    var result = await Navigator.pushNamed(context, routeName);
    return result;
  }

  //根据名称跳转到新页面并结束当前页面
  static void toNextRouteWithNameAndFinish(
      BuildContext context, String routeName) {
    if (StringUtils.isEmpty(routeName)) throw Exception("路由名称不能为空，请检查");
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}
