import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///首页路由

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
      floatingActionButton: GestureDetector(
        onTap: () => {
          //跳转到账单页面
          JumpUtils.toNextRouteWithName(
              context, RouteNameConstant.BILL_HOME_ROUTE)
        },
        child: Card(
          elevation: 10.0,
          shape: CircleBorder(),
          color: Colors.blueAccent,
          shadowColor: Colors.blueGrey,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 35.0,
                ),
                Text(
                  StringConstant.BILL,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
