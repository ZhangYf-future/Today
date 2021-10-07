import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/ui/home/home_block_bill.dart';
import 'package:today/ui/home/home_block_weather.dart';
import 'package:today/ui/home/home_route_mvp.dart';
import 'package:today/utils/constant.dart';

///首页路由
class HomeRoute extends StatelessWidget implements BaseView {
  //需要显示的数据信息
  List<HomeBlockBean> _homeBlockList;

  //构造函数
  HomeRoute() {
    final HomeRoutePresenter presenter = HomeRoutePresenter(this);
    _homeBlockList = presenter.getHomeBlocks();
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
                    return HomeBillBlockWidget(this._homeBlockList[position]);
                  //天气
                  case HomeBlockConstant.HOME_BLOCK_TYPE_WEATHER:
                    return HomeBlockWeatherWidget();
                  //默认返回null
                  default:
                    return null;
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
