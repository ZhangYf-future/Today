import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/ui/weather/home/weather_info_mvp.dart';

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
                child: Text(_cityDBBean.name + _cityDBBean.region),
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
        children: [Text("${bean.temp}℃ / ${bean.feelsLike}℃")],
      );
}