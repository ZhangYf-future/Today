import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_now_bean.g.dart';

///实时天气信息的数据类
@JsonSerializable()
class WeatherNowBean extends BaseHttpBean {
  //更新时间,可能为空
  String? updateTime;

  //响应式页面，可以在web中打开的链接,可能为空
  String? fxLink;

  //当前详细信息的数据,可能为空
  WeatherNowRealBean? now;

  //当前的位置信息，可能为空
  @JsonKey(ignore: true)
  BaiduLocation? location;

  //构造函数
  WeatherNowBean(this.updateTime, this.fxLink, this.now)
      : super("-1", "no message");

  //将json数据创建为当前model
  factory WeatherNowBean.fromJson(Map<String, dynamic> json) =>
      _$WeatherNowBeanFromJson(json);
}

///实时天气数据中的实际信息
@JsonSerializable()
class WeatherNowRealBean {
  //数据观测时间
  String obsTime;
  //温度，默认单位为摄氏度
  String temp;
  //体感温度，默认单位为摄氏度
  String feelsLike;
  //天气状态的图标代码
  String icon;
  //天气状态的文字描述
  String text;
  //风向的角度
  String wind360;
  //风向
  String windDir;
  //风力等级
  String windScale;
  //风速 公里/每小时
  String windSpeed;
  //相对湿度，百分比值
  String humidity;
  //当前小时累计降水量
  String precip;
  //大气压强:百帕
  String pressure;
  //能见度 单位公里
  String vis;
  //云量 百分比数值
  String cloud;
  //露点温度
  String dew;

  //构造函数
  WeatherNowRealBean(
      this.obsTime,
      this.temp,
      this.feelsLike,
      this.icon,
      this.text,
      this.wind360,
      this.windDir,
      this.windScale,
      this.windSpeed,
      this.humidity,
      this.precip,
      this.pressure,
      this.vis,
      this.cloud,
      this.dew);

  //将json数据转换为model的方法
  factory WeatherNowRealBean.fromJson(Map<String, dynamic> json) =>
      _$WeatherNowRealBeanFromJson(json);
}
