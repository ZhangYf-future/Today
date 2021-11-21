// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_air_quality_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherAirQualityBean _$WeatherAirQualityBeanFromJson(
        Map<String, dynamic> json) =>
    WeatherAirQualityBean(
      json['code'] as String?,
      json['message'] as String?,
    )
      ..updateTime = json['updateTime'] as String?
      ..fxLink = json['fxLink'] as String?
      ..now = json['now'] == null
          ? null
          : WeatherAirQualityRealBean.fromJson(
              json['now'] as Map<String, dynamic>);

Map<String, dynamic> _$WeatherAirQualityBeanToJson(
        WeatherAirQualityBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'now': instance.now,
    };

WeatherAirQualityRealBean _$WeatherAirQualityRealBeanFromJson(
        Map<String, dynamic> json) =>
    WeatherAirQualityRealBean(
      json['pubTime'] as String,
      json['aqi'] as String,
      json['level'] as String,
      json['category'] as String,
      json['primary'] as String,
      json['pm10'] as String,
      json['pm2p5'] as String,
      json['no2'] as String,
      json['so2'] as String,
      json['o3'] as String,
    );

Map<String, dynamic> _$WeatherAirQualityRealBeanToJson(
        WeatherAirQualityRealBean instance) =>
    <String, dynamic>{
      'pubTime': instance.pubTime,
      'aqi': instance.aqi,
      'level': instance.level,
      'category': instance.category,
      'primary': instance.primary,
      'pm10': instance.pm10,
      'pm2p5': instance.pm2p5,
      'no2': instance.no2,
      'so2': instance.so2,
      'o3': instance.o3,
    };
