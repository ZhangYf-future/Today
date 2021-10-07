import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

class HomeBlockWeatherWidget extends StatefulWidget {
  @override
  _WeatherBlockState createState() => _WeatherBlockState();
}

class _WeatherBlockState extends State<HomeBlockWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: GestureDetector(
        child: Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [Colors.blueAccent, Colors.redAccent])),
          child: Text("天气"),
        ),
        onTap: () => JumpUtils.toNextRouteWithName(
            context, RouteNameConstant.WEATHER_HOME_ROUTE),
      ),
    );
  }
}
