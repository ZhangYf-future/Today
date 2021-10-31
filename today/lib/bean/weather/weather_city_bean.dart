import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_city_bean.g.dart';

///天气功能城市信息

@JsonSerializable()
class WeatherCityListBean extends BaseHttpBean{
  List<WeatherCityBean> location;

  WeatherCityListBean(this.location):super("0","success");

  factory WeatherCityListBean.fromJson(Map<String,dynamic> json) => _$WeatherCityListBeanFromJson(json);
}

@ JsonSerializable()
class WeatherCityBean{
 String name;
  String id;
  String lat;
  String lon;
  String adm2;//北京
  String adm1;//北京市
  String country;//中国
  String tz;//Asia/Shanghai
  String utcOffset;//+08:00
  String isDst;//0 当前是否处于夏令时 1是 0否
  String type;//city 城市属性
  String rank;//10 地区评分
  String fxLink;//网页链接

  WeatherCityBean(
    this.name,
    this.id,
    this.lat,
    this.lon,
    this.adm2,
    this.adm1,
    this.country,
    this.tz,
    this.utcOffset,
    this.isDst,
    this.type,
    this.rank,
    this.fxLink
  );

factory WeatherCityBean.fromJson(Map<String,dynamic> json) => _$WeatherCityBeanFromJson(json);

}