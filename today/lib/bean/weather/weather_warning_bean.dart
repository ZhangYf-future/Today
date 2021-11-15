import 'package:json_annotation/json_annotation.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
part 'weather_warning_bean.g.dart';

///天气灾害预警信息
@JsonSerializable()
class WeatherWarningBean extends BaseHttpBean{
  //更新时间
  String? updateTime;
  //网络链接地址
  String? fxLink;
  //报警列表
  List<WeatherWarningRealBean>? warning;

  WeatherWarningBean(String? code, String? message) : super(code, message);

  //从json解析数据
  factory WeatherWarningBean.fromJson(Map<String,dynamic> json) => _$WeatherWarningBeanFromJson(json);

} 

@JsonSerializable()
class WeatherWarningRealBean{
  //id
  String id;
  //预警发布单位,可为空
  String? sender;
  //预警发布时间
  String pubTime;
  //预警信息标题
  String title;
  //预警开始时间，可能为空
  String? startTime;
  //预警结束时间，可能为空
  String? endTime;
  //预警状态，可能为空(active 预警中或首次预警 update预警信息更新 cancel取消预警)
  String? status;
  //预警等级 蓝色
  String level;
  //预警类型id
  String type;
  //预警类型名称
  String typeName;
  //预警详细文字描述
  String text;

  WeatherWarningRealBean(
    this.id,
    this.sender,
    this.pubTime,
    this.title,
    this.startTime,
    this.endTime,
    this.status,
    this.level,
    this.type,
    this.typeName,
    this.text
  );

  //从json中解析数据
  factory WeatherWarningRealBean.fromJson(Map<String,dynamic> json) => _$WeatherWarningRealBeanFromJson(json);

}