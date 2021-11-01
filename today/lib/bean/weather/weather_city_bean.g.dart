// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_city_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCityListBean _$WeatherCityListBeanFromJson(Map<String, dynamic> json) =>
    WeatherCityListBean(
      (json['location'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WeatherCityBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..code = json['code'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$WeatherCityListBeanToJson(
        WeatherCityListBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'location': instance.location,
    };

WeatherCityBean _$WeatherCityBeanFromJson(Map<String, dynamic> json) =>
    WeatherCityBean(
      json['name'] as String,
      json['id'] as String,
      json['lat'] as String,
      json['lon'] as String,
      json['adm2'] as String,
      json['adm1'] as String,
      json['country'] as String,
      json['tz'] as String,
      json['utcOffset'] as String,
      json['isDst'] as String,
      json['type'] as String,
      json['rank'] as String,
      json['fxLink'] as String,
    );

Map<String, dynamic> _$WeatherCityBeanToJson(WeatherCityBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'lat': instance.lat,
      'lon': instance.lon,
      'adm2': instance.adm2,
      'adm1': instance.adm1,
      'country': instance.country,
      'tz': instance.tz,
      'utcOffset': instance.utcOffset,
      'isDst': instance.isDst,
      'type': instance.type,
      'rank': instance.rank,
      'fxLink': instance.fxLink,
    };
