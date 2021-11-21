import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_air_quality_bean.g.dart';

///实时空气质量数据
@JsonSerializable()
class WeatherAirQualityBean extends BaseHttpBean{

  //数据更新时间
  String? updateTime;

  //网页链接
  String? fxLink;

  //真正的数据信息
  WeatherAirQualityRealBean? now;

  //station信息暂时没有用到
  
  WeatherAirQualityBean(String? code, String? message) : super(code, message);

  factory WeatherAirQualityBean.fromJson(Map<String,dynamic> json) => _$WeatherAirQualityBeanFromJson(json);

}


///真实的实时空气质量信息
@JsonSerializable()
class WeatherAirQualityRealBean{
  //数据更新时间
  String pubTime;
  //空气质量指数
  String aqi;
  //空气质量指数等级
  String level;
  //空气质量指数级别--优
  String category;
  //空气中的主要污染物，空气质量指数为优时 此数据为NA
  String primary;
  //PM10
  String pm10;
  //PM2.5
  String pm2p5;
  //no2 二氧化氮
  String no2;
  //二氧化硫
  String so2;
  //臭氧
  String o3;

  WeatherAirQualityRealBean(
    this.pubTime,
    this.aqi,
    this.level,
    this.category,
    this.primary,
    this.pm10,
    this.pm2p5,
    this.no2,
    this.so2,
    this.o3
  );
  
  factory WeatherAirQualityRealBean.fromJson(Map<String,dynamic> json) => _$WeatherAirQualityRealBeanFromJson(json);

}