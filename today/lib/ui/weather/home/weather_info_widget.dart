import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/bean/weather/weather_hour_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/bean/weather/weather_seven_day_bean.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/ui/weather/home/weather_info_mvp.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart' as date;

///页面UI
class WeatherInfoWidget extends StatefulWidget {
  //城市信息，可能是经纬度信息，也可能是城市id
  final WeatherCityDBBean _cityInfo;

  WeatherInfoWidget(this._cityInfo);

  @override
  WeatherInfoState createState() => WeatherInfoState();
}

class WeatherInfoState extends BaseState<WeatherInfoWidget>
    with AutomaticKeepAliveClientMixin {
  //请求数据的presenter
  WeatherInfoPresenter? _presenter;

  //实时天气信息
  WeatherNowBean? _weatherNowBean;

  //24小时逐小时天气预报
  WeatherHourBean? _weatherHourBean;

  //未来七天的天气预报
  WeatherSevenDayBean? _weatherSevenDayBean;

  WeatherInfoState() {
    this._presenter = WeatherInfoPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    //请求实时天气
    this._presenter!.getWeatherNowInfo(widget._cityInfo.hfId);
  }

  //实时天气请求成功的回调
  void requestWeatherNowSuccess(WeatherNowBean bean) {
    this._weatherNowBean = bean;
    this.updatePage();
  }

  //逐小时天气预报信息请求成功
  void requestWeatherHourSuccess(WeatherHourBean bean) {
    this._weatherHourBean = bean;
    this.updatePage();
  }

  //未来七天天气预报请求成功
  void requestWeatherSevenDay(WeatherSevenDayBean bean) {
    this._weatherSevenDayBean = bean;
    this.updatePage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        displacement: 40.0,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                //实时天气部分
                _WeatherNowWidget(widget._cityInfo, _weatherNowBean),

                //逐小时天气预报
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: this._weatherHourBean == null ||
                          this._weatherHourBean!.hourly == null
                      ? null
                      : _WeatherHourWidget(this._weatherHourBean!),
                ),

                //未来七天的天气预报
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: this._weatherSevenDayBean == null
                      ? null
                      : _WeatherSevenDayWidget(this._weatherSevenDayBean!),
                ),
              ],
            ),
          ),
        ),
        onRefresh: () async =>
            this._presenter!.getWeatherNowInfo(widget._cityInfo.hfId));
  }

  @override
  bool get wantKeepAlive => true;
}

///实时天气部分
class _WeatherNowWidget extends StatelessWidget {
  //定位信息
  final WeatherCityDBBean _cityDBBean;
  final WeatherNowBean? _weatherNowBean;

  _WeatherNowWidget(this._cityDBBean, this._weatherNowBean);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.blueAccent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //上面显示城市名称信息
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsetsDirectional.all(20.0),
                child: Text(
                  _cityDBBean.name + " · " + _cityDBBean.region,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                  ),
                ),
              ),
            ),

            //中间显示当前的温度和体感温度
            _weatherNowBean != null && _weatherNowBean!.now != null
                ? _createWeatherWidget(_weatherNowBean!.now!)
                : Container(),
          ],
        ),
      );

  //请求到的实时天气不为空的时候的widget
  Widget _createWeatherWidget(WeatherNowRealBean bean) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                  text: bean.text,
                  style: TextStyle(
                      color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                      fontSize: 28.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: " · " + bean.temp + "℃",
                      style: TextStyle(
                          color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                          fontSize: 28.0),
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                //风力信息，显示风向和风速
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      bean.windDir + " · " + bean.windSpeed + "km/h",
                      style: TextStyle(
                        color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),

                //湿度信息
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      StringConstant.HUMIDITY_INFO + ": " + bean.humidity + "%",
                      style: TextStyle(
                          color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                          fontSize: 16.0),
                    ),
                  ),
                ),

                //体感温度
                Expanded(
                    child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    StringConstant.FEELS_LIKE + ": " + bean.feelsLike + "℃",
                    style: TextStyle(
                      color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                      fontSize: 16.0,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      );
}

//逐小时天气预报部分
class _WeatherHourWidget extends StatelessWidget {
  final WeatherHourBean _weatherHourBean;

  _WeatherHourWidget(this._weatherHourBean);

  //返回当前图片的途径信息
  String _getImagePath(WeatherHourRealBean bean) {
    String image = bean.icon;
    if (image.startsWith("8")) {
      return "images/${bean.icon}.svg";
    }
    return "images/${bean.icon}-fill.svg";
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.blueAccent,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: _weatherHourBean.hourly!
                .map(
                  (item) => Container(
                    padding: EdgeInsetsDirectional.all(10.0),
                    child: Column(
                      children: [
                        //天气图标
                        SvgPicture.asset(
                          _getImagePath(item),
                          width: 30.0,
                          height: 30.0,
                          color: Colors.deepOrangeAccent,
                        ),

                        //天气文本和温度
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Center(
                            child: Text(
                              "${item.text} · ${item.temp}℃",
                              style: TextStyle(color: Colors.tealAccent),
                            ),
                          ),
                        ),

                        //时间
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 6.0,
                          ),
                          child: Center(
                            child: Text(
                              date.DateUtils.string2Date(item.fxTime),
                              style: TextStyle(
                                color: Colors.limeAccent,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

//未来七天的天气预报信息
class _WeatherSevenDayWidget extends StatelessWidget {
  //每一天的天气信息
  final WeatherSevenDayBean _bean;

  _WeatherSevenDayWidget(this._bean);

  //返回当前图片的途径信息
  String _getImagePath(WeatherSevenDayRealBean bean) {
    String image = bean.iconDay;
    if (image.startsWith("8")) {
      return "images/${bean.iconDay}.svg";
    }
    return "images/${bean.iconDay}-fill.svg";
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.blueAccent,
        child: Column(
          children: this
              ._bean
              .daily!
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //时间
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          date.DateUtils.getDayDescription(e.fxDate),
                          style: TextStyle(
                              color: Colors.amberAccent, fontSize: 14.0),
                        ),
                      ),
                    ),

                    //天气温度图标和文本描述
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              this._getImagePath(e),
                              color: Colors.orangeAccent,
                              width: 20.0,
                              height: 20.0,
                            ),
                            //天气描述信息
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                e.textDay,
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),

                    //天气温度
                    Expanded(
                      child: Text(
                        "${e.tempMin}℃ ~ ${e.tempMax}℃",
                        style: TextStyle(
                            color: Colors.amberAccent, fontSize: 14.0),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
}
