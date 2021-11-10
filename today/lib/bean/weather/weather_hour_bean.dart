import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_hour_bean.g.dart';

///逐小时天气预报
@JsonSerializable()
class WeatherHourBean extends BaseHttpBean {
  //数据更新时间，可能为空
  String? updateTime;

  //当前页面响应式页面
  String? fxLink;

  //逐小时数据
  List<WeatherHourRealBean>? hourly;

  WeatherHourBean() : super("-1", "unknow");

  factory WeatherHourBean.fromJson(Map<String, dynamic> json) =>
      _$WeatherHourBeanFromJson(json);
}

//逐小时天气预报真实数据信息
@JsonSerializable()
class WeatherHourRealBean {
  //预报时间: 2021-02-16T15:00+08:00
  String fxTime;

  //温度
  String temp;

  //天气状况图标代码
  String icon;

  //天气状况文字描述
  String text;

  //风向角度
  String wind360;

  //风向
  String windDir;

  //风力等级
  String windScale;

  //风速
  String windSpeed;

  //相对湿度
  String humidity;

  //当前小时累计降水量
  String precip;

  //逐小时预报降水概率,可能为空
  String? pop;

  //大气压强，单位百帕
  String pressure;

  //云量，单位百分比
  String cloud;

  //露点温度
  String dew;

  //原始数据来源
  String? sources;

  //数据许可和版权声明
  String? license;

  WeatherHourRealBean(
      this.fxTime,
      this.temp,
      this.icon,
      this.text,
      this.wind360,
      this.windDir,
      this.windScale,
      this.windSpeed,
      this.humidity,
      this.precip,
      this.pop,
      this.pressure,
      this.cloud,
      this.dew,
      this.sources,
      this.license);

  factory WeatherHourRealBean.fromJson(Map<String,dynamic> json) => _$WeatherHourRealBeanFromJson(json);
}
