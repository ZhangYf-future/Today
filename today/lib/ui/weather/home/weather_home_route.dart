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
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Text("天气首页"),
      ),
    );
  }
}
