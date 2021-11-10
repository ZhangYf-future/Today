// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hour_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherHourBean _$WeatherHourBeanFromJson(Map<String, dynamic> json) =>
    WeatherHourBean()
      ..code = json['code'] as String?
      ..message = json['message'] as String?
      ..updateTime = json['updateTime'] as String?
      ..fxLink = json['fxLink'] as String?
      ..hourly = (json['hourly'] as List<dynamic>?)
          ?.map((e) => WeatherHourRealBean.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WeatherHourBeanToJson(WeatherHourBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'hourly': instance.hourly,
    };

WeatherHourRealBean _$WeatherHourRealBeanFromJson(Map<String, dynamic> json) =>
    WeatherHourRealBean(
      json['fxTime'] as String,
      json['temp'] as String,
      json['icon'] as String,
      json['text'] as String,
      json['wind360'] as String,
      json['windDir'] as String,
      json['windScale'] as String,
      json['windSpeed'] as String,
      json['humidity'] as String,
      json['precip'] as String,
      json['pop'] as String?,
      json['pressure'] as String,
      json['cloud'] as String,
      json['dew'] as String,
      json['sources'] as String?,
      json['license'] as String?,
    );

Map<String, dynamic> _$WeatherHourRealBeanToJson(
        WeatherHourRealBean instance) =>
    <String, dynamic>{
      'fxTime': instance.fxTime,
      'temp': instance.temp,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.windDir,
      'windScale': instance.windScale,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pop': instance.pop,
      'pressure': instance.pressure,
      'cloud': instance.cloud,
      'dew': instance.dew,
      'sources': instance.sources,
      'license': instance.license,
    };
