// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_seven_day_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherSevenDayBean _$WeatherSevenDayBeanFromJson(Map<String, dynamic> json) =>
    WeatherSevenDayBean(
      json['code'] as String?,
      json['message'] as String?,
    )
      ..updateTime = json['updateTime'] as String?
      ..fxLink = json['fxLink'] as String?
      ..daily = (json['daily'] as List<dynamic>?)
          ?.map((e) =>
              WeatherSevenDayRealBean.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WeatherSevenDayBeanToJson(
        WeatherSevenDayBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'daily': instance.daily,
    };

WeatherSevenDayRealBean _$WeatherSevenDayRealBeanFromJson(
        Map<String, dynamic> json) =>
    WeatherSevenDayRealBean(
      json['fxDate'] as String,
      json['sunrise'] as String,
      json['sunset'] as String,
      json['moonrise'] as String,
      json['moonset'] as String,
      json['moonPhase'] as String,
      json['tempMax'] as String,
      json['tempMin'] as String,
      json['iconDay'] as String,
      json['textDay'] as String,
      json['iconNight'] as String,
      json['textNight'] as String,
      json['wind360Day'] as String,
      json['windDirDay'] as String,
      json['windScaleDay'] as String,
      json['windSpeedDay'] as String,
      json['wind360Night'] as String,
      json['windDirNight'] as String,
      json['windScaleNight'] as String,
      json['windSpeedNight'] as String,
      json['precip'] as String,
      json['uvIndex'] as String,
      json['humidity'] as String,
      json['pressure'] as String,
      json['vis'] as String,
      json['cloud'] as String,
      json['sources'] as String?,
      json['license'] as String?,
    );

Map<String, dynamic> _$WeatherSevenDayRealBeanToJson(
        WeatherSevenDayRealBean instance) =>
    <String, dynamic>{
      'fxDate': instance.fxDate,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moonPhase': instance.moonPhase,
      'tempMax': instance.tempMax,
      'tempMin': instance.tempMin,
      'iconDay': instance.iconDay,
      'textDay': instance.textDay,
      'iconNight': instance.iconNight,
      'textNight': instance.textNight,
      'wind360Day': instance.wind360Day,
      'windDirDay': instance.windDirDay,
      'windScaleDay': instance.windScaleDay,
      'windSpeedDay': instance.windSpeedDay,
      'wind360Night': instance.wind360Night,
      'windDirNight': instance.windDirNight,
      'windScaleNight': instance.windScaleNight,
      'windSpeedNight': instance.windSpeedNight,
      'precip': instance.precip,
      'uvIndex': instance.uvIndex,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'sources': instance.sources,
      'license': instance.license,
    };
