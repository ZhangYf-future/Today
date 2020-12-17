import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///首页路由
//TODO 首页还没想好怎么做，先添加一个按钮跳转到账单相关的页面

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
      body: MaterialButton(
        child: Center(
          child: Text(
            "我的账单",
            style: TextStyle(
              fontSize: 16.0,
              color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
            ),
          ),
        ),
        onPressed: () {
          //跳转到账单页面
          JumpUtils.toNextRouteWithName(
              context, RouteNameConstant.BILL_HOME_ROUTE);
        },
      ),
    );
  }
}
