import 'package:flutter/material.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/constact/constact_string.dart' as cs;
import 'package:today/constact/constant_route.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///首页天气Widget
class HomeBlockWeatherWidget extends StatelessWidget {
  final HomeBlockBean _homeBlockBean;
  final WeatherNowBean? _weatherBean;

  HomeBlockWeatherWidget(this._homeBlockBean, this._weatherBean);

  //页面UI
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: GestureDetector(
        child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                //shape: BoxShape.rectangle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blueAccent, Colors.redAccent])),
            child: _weatherBean == null || _weatherBean!.now == null
                ? _createNoWeatherWidget()
                : _createWeatherWidget()),
        onTap: () => JumpUtils.toNextRouteWithName(
            context, RouteNameConstant.WEATHER_HOME_ROUTE),
      ),
    );
  }

  //没有天气信息时候的UI
  Widget _createNoWeatherWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            this._homeBlockBean.name,
            style: TextStyle(
                color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR, fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              this._homeBlockBean.title,
              style:
                  TextStyle(color: ColorConstant.COLOR_F2F2F2, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }

  //有天气信息时候的UI
  Widget _createWeatherWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //右上角显示位置信息
        // (_weatherBean != null && _weatherBean!.location != null)
        //     ? Padding(
        //         padding: EdgeInsets.only(top: 10.0, right: 10.0),
        //         child: Align(
        //           alignment: Alignment.centerRight,
        //           child: Text(
        //             _weatherBean!.location!.district ?? "",
        //             style: TextStyle(color: Colors.redAccent),
        //           ),
        //         ),
        //       )
        //     :
        Container(),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Text(
            cs.StringConstant.WEATHER_NOW,
            style: TextStyle(
              color: ColorConstant.COLOR_F2F2F2,
              fontSize: 16.0,
            ),
          ),
        ),
        Center(
          child: RichText(
            text: TextSpan(
              text: "${_weatherBean!.now!.temp}℃",
              style: TextStyle(
                  color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: " ${_weatherBean!.now!.text}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, right: 15.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              cs.StringConstant.WEATHER_CLICK_WATCH_DETAILS,
              style: TextStyle(
                color: ColorConstant.COLOR_F2F2F2,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
