// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_life_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherLifeBean _$WeatherLifeBeanFromJson(Map<String, dynamic> json) =>
    WeatherLifeBean(
      json['code'] as String?,
      json['message'] as String?,
    )
      ..updateTime = json['updateTime'] as String?
      ..fxLink = json['fxLink'] as String?
      ..daily = (json['daily'] as List<dynamic>?)
          ?.map((e) => WeatherLifeRealBean.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WeatherLifeBeanToJson(WeatherLifeBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'daily': instance.daily,
    };

WeatherLifeRealBean _$WeatherLifeRealBeanFromJson(Map<String, dynamic> json) =>
    WeatherLifeRealBean(
      json['date'] as String,
      json['type'] as String,
      json['name'] as String,
      json['level'] as String,
      json['category'] as String,
      json['text'] as String?,
    );

Map<String, dynamic> _$WeatherLifeRealBeanToJson(
        WeatherLifeRealBean instance) =>
    <String, dynamic>{
      'date': instance.date,
      'type': instance.type,
      'name': instance.name,
      'level': instance.level,
      'category': instance.category,
      'text': instance.text,
    };
