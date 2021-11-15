import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_life_bean.g.dart';

/// 天气信息生活指数
@JsonSerializable()
class WeatherLifeBean extends BaseHttpBean{

  //数据更新时间
  String? updateTime;
  //web链接
  String? fxLink;
  //信息列表
  List<WeatherLifeRealBean>? daily;

  WeatherLifeBean(String? code, String? message) : super(code, message);

  //从json中解析数据
  factory WeatherLifeBean.fromJson(Map<String,dynamic> json) => _$WeatherLifeBeanFromJson(json);

}

@JsonSerializable()
class WeatherLifeRealBean{
  //日期 yyyy-MM-dd
  String date;
  //类型
  String type;
  //名称
  String name;
  //等级
  String level;
  //级别名称
  String category;
  //详细描述，可能为空
  String? text;


  WeatherLifeRealBean(
    this.date,
    this.type,
    this.name,
    this.level,
    this.category,
    this.text
  );

  //从json中解析数据
  factory WeatherLifeRealBean.fromJson(Map<String,dynamic> json) => _$WeatherLifeRealBeanFromJson(json);
}