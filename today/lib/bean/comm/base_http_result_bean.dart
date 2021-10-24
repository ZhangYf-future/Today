import 'package:json_annotation/json_annotation.dart';
part 'base_http_result_bean.g.dart';

///Http请求数据的基类

@JsonSerializable()
class BaseHttpBean {
  //返回的状态码
  String? code;
  //返回的状态信息
  String? message;

  BaseHttpBean(this.code, this.message);

  factory BaseHttpBean.fromJson(Map<String, dynamic> json) =>
      _$BaseHttpBeanFromJson(json);
}
