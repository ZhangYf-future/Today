import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/ui/weather/home/weather_home_mvp.dart';

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
      body: PageView(
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
    );
  }
}
