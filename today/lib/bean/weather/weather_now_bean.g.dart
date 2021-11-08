// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_now_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherNowBean _$WeatherNowBeanFromJson(Map<String, dynamic> json) =>
    WeatherNowBean(
      json['updateTime'] as String?,
      json['fxLink'] as String?,
      json['now'] == null
          ? null
          : WeatherNowRealBean.fromJson(json['now'] as Map<String, dynamic>),
    )
      ..code = json['code'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$WeatherNowBeanToJson(WeatherNowBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'now': instance.now,
    };

WeatherNowRealBean _$WeatherNowRealBeanFromJson(Map<String, dynamic> json) =>
    WeatherNowRealBean(
      json['obsTime'] as String,
      json['temp'] as String,
      json['feelsLike'] as String,
      json['icon'] as String,
      json['text'] as String,
      json['wind360'] as String,
      json['windDir'] as String,
      json['windScale'] as String,
      json['windSpeed'] as String,
      json['humidity'] as String,
      json['precip'] as String,
      json['pressure'] as String,
      json['vis'] as String,
      json['cloud'] as String,
      json['dew'] as String,
    );

Map<String, dynamic> _$WeatherNowRealBeanToJson(WeatherNowRealBean instance) =>
    <String, dynamic>{
      'obsTime': instance.obsTime,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.windDir,
      'windScale': instance.windScale,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'dew': instance.dew,
    };
