import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/constact/constant_string.dart';
import 'package:today/constact/constant_route.dart';
import 'package:today/db/db_utils.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

/// APP启动页

class SplashRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ContentWidget(),
      backgroundColor: Colors.white,
    );
  }
}

/// 页面内容部分，为了方便以后进行扩展，单独把内容部分提取出来
class _ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContentState();
  }
}

class _ContentState extends State<_ContentWidget> {
  //启动页文本
  static const String _splashText = """
    不积跬步，无以至千里；
    \n\n
            不积小流，无以成江海。
  """;

  @override
  void initState() {
    super.initState();
    _haveDB();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              _splashText,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            StringConstant.WEATHER_DATA_FROM,
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        )
      ],
    );
  }

  //经过1秒之后跳转到首页
  void _toHome() {
    Future.delayed(
        Duration(seconds: 1),
        () => JumpUtils.toNextRouteWithNameAndFinish(
            context, RouteNameConstant.HOME_ROUTE));
  }

  //判断当前是否有数据库存在
  void _haveDB() async {
    var utils = DBUtils();
    //打开数据库连接
    await utils.openDB();
    //等待1秒后跳转到首页
    _toHome();
  }
}
