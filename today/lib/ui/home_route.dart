import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///首页路由
class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Scaffold(
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
          endDrawer: _EndDrawerWidget(),
          endDrawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: 50.0,
          appBar: AppBar(
            actions: [
              //打开右边抽屉的icon
              Builder(builder: (BuildContext _context) {
                return IconButton(
                    onPressed: () {
                      print("点击按钮");
                      Scaffold.of(_context).openEndDrawer();
                    },
                    icon: Icon(Icons.menu));
              }),
            ],
          ),
        ));
  }
}

//右边显示一个菜单栏
class _EndDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "密码管理",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );
  }
}
