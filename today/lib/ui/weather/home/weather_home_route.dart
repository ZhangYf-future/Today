import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/ui/weather/home/weather_home_mvp.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///天气首页
class WeatherHomeRoute extends StatefulWidget {
  @override
  WeatherHomeState createState() => WeatherHomeState();
}

class WeatherHomeState extends BaseState<WeatherHomeRoute> {
  WeatherHomePresenter? _presenter;

  WeatherHomeState() {
    _presenter = WeatherHomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter!.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //页面中间是显示当前天气信息的Widget
          Container(
            constraints: BoxConstraints.expand(),
            child:  PageView(
              children: [
                Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("第一个页面"),
                ),
                Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("第二个页面"),
                ),
                Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("第三个页面"),
                ),
              ],
            ),
          ),
          
          //页面底部是当前的指示器
        ],
      ),

      floatingActionButton: GestureDetector(
        child: Container(
          constraints: BoxConstraints.expand(width: 50.0,height: 50.0),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.blueGrey,offset: Offset(0, 1),),
            ]
          ),
          child: Icon(Icons.add,color: Colors.white,),
        ),

        onTap: () => JumpUtils.toNextRouteWithName(context, RouteNameConstant.WEATHER_ADD_CITY_ROUTE),
      ),
    );
  }
}
