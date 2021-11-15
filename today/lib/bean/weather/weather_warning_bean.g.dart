// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_warning_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherWarningBean _$WeatherWarningBeanFromJson(Map<String, dynamic> json) =>
    WeatherWarningBean(
      json['code'] as String?,
      json['message'] as String?,
    )
      ..updateTime = json['updateTime'] as String?
      ..fxLink = json['fxLink'] as String?
      ..warning = (json['warning'] as List<dynamic>?)
          ?.map(
              (e) => WeatherWarningRealBean.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WeatherWarningBeanToJson(WeatherWarningBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'warning': instance.warning,
    };

WeatherWarningRealBean _$WeatherWarningRealBeanFromJson(
        Map<String, dynamic> json) =>
    WeatherWarningRealBean(
      json['id'] as String,
      json['sender'] as String?,
      json['pubTime'] as String,
      json['title'] as String,
      json['startTime'] as String?,
      json['endTime'] as String?,
      json['status'] as String?,
      json['level'] as String,
      json['type'] as String,
      json['typeName'] as String,
      json['text'] as String,
    );

Map<String, dynamic> _$WeatherWarningRealBeanToJson(
        WeatherWarningRealBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'pubTime': instance.pubTime,
      'title': instance.title,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      'level': instance.level,
      'type': instance.type,
      'typeName': instance.typeName,
      'text': instance.text,
    };
