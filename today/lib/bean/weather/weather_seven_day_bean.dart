import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_seven_day_bean.g.dart';

///未来七日天气预报数据
@JsonSerializable()
class WeatherSevenDayBean extends BaseHttpBean{

  String? updateTime;
  String? fxLink;
  List<WeatherSevenDayRealBean>? daily;
  
  WeatherSevenDayBean(String? code, String? message) : super(code, message);

  factory WeatherSevenDayBean.fromJson(Map<String,dynamic> json) => _$WeatherSevenDayBeanFromJson(json);

}


///未来七日天气预报真实数据
@JsonSerializable()
class WeatherSevenDayRealBean{

  //预报日期
  String fxDate;

  //日出时间
  String sunrise;

  //日落时间
  String sunset;

  //月升时间
  String moonrise;

  //月落时间
  String moonset;

  //月相名称
  String moonPhase;

  //预报当天最高温度
  String tempMax;

  //预报当天最低温度
  String tempMin;

  //白天天气图标代码
  String iconDay;

  //白天天气文字描述
  String textDay;

  //夜间天气图标代码
  String iconNight;

  //夜间天气文字描述
  String textNight;

  //白天风向360角度
  String wind360Day;

  //白天风向
  String windDirDay;

  //白天风力等级
  String windScaleDay;

  //白天风速 km/h
  String windSpeedDay;

  //夜间风向360角度
  String wind360Night;

  //夜间风向
  String windDirNight;

  //夜间风力等级
  String windScaleNight;

  //夜间风速 km/h
  String windSpeedNight;

  //当天总降水量 毫米
  String precip;

  //紫外线强度指数
  String uvIndex;

  //相对湿度 百分比
  String humidity;

  //大气压强 百帕
  String pressure;

  //能见度  公里
  String vis;

  //云量  百分比 
  String cloud;

  //原始数据来源  可能为空
  String? sources;

  //数据许可或版权声明 可能为空
  String? license;


  WeatherSevenDayRealBean(
    this.fxDate,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.tempMax,
    this.tempMin,
    this.iconDay,
    this.textDay,
    this.iconNight,
    this.textNight,
    this.wind360Day,
    this.windDirDay,
    this.windScaleDay,
    this.windSpeedDay,
    this.wind360Night,
    this.windDirNight,
    this.windScaleNight,
    this.windSpeedNight,
    this.precip,
    this.uvIndex,
    this.humidity,
    this.pressure,
    this.vis,
    this.cloud,
    this.sources,
    this.license
  );

  factory WeatherSevenDayRealBean.fromJson(Map<String,dynamic> json) => _$WeatherSevenDayRealBeanFromJson(json);
}