import 'package:dio/dio.dart';
import 'package:today/bean/weather/weather_air_quality_bean.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/bean/weather/weather_hour_bean.dart';
import 'package:today/bean/weather/weather_life_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/bean/weather/weather_seven_day_bean.dart';
import 'package:today/bean/weather/weather_warning_bean.dart';
import 'package:today/constact/constact_dio.dart';
import 'package:today/net/http_dio.dart';

var weatherHelper = WeatherHttpHelper._internal();

class WeatherHttpHelper {
  //私有化构造函数
  WeatherHttpHelper._internal();

  //获取实时天气
  Future<WeatherNowBean> getWeatherNow(String location) async {
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    queryParams["location"] = location;
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_WEATHER_NOW, queryParams);
    return WeatherNowBean.fromJson(result.data);
  }

  //根据输入的文本查询城市信息
  Future<WeatherCityListBean?> queryCityList(String queryName) async {
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER_CITY;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    queryParams["location"] = queryName;
    //请求20条数据
    queryParams["number"] = 20;
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_SEARCH_CITY_LIST, queryParams);
    if (result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE) {
      return WeatherCityListBean.fromJson(result.data);
    } else {
      return null;
    }
  }

  //请求逐小时天气预报
  Future<WeatherHourBean?> getWeatherHour(String location) async {
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    queryParams[DioNetConstant.REQUEST_WEATHER_LOCATION] = location;
    //开始请求
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_WEATHER_HOUR, queryParams);

    if (result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE) {
      return WeatherHourBean.fromJson(result.data);
    }
    return null;
  }

  //请求未来七天的天气预报
  Future<WeatherSevenDayBean?> getWeatherSevenDay(String location) async {
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    queryParams[DioNetConstant.REQUEST_WEATHER_LOCATION] = location;
    //开始请求
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_WEATHER_SEVEN_DAY, queryParams);

    //如果请求成功，将数据返回出去
    if (result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE) {
      return WeatherSevenDayBean.fromJson(result.data);
    }
    //数据请求失败，返回空
    return null;
  }

  //请求当天的生活指数信息
  Future<WeatherLifeBean?> getWeatherLifeInfo(String location) async{
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    //设置location
    queryParams[DioNetConstant.REQUEST_WEATHER_LOCATION] = location;
    //设置type为请求全部天气指数
    queryParams[DioNetConstant.REQUEST_WEATHER_TYPE] = "0";
    //开始请求
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_WEATHER_LIFE, queryParams);

    //如果请求成功，将数据返回出去
    if (result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE) {
      return WeatherLifeBean.fromJson(result.data);
    }
    //数据请求失败，返回空
    return null;
  }

  //请求报警信息
  Future<WeatherWarningBean?> getWeatherWarningInfo(String location) async{
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    //设置location
    queryParams[DioNetConstant.REQUEST_WEATHER_LOCATION] = location;
    //开始请求
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_WEATHER_WARNING, queryParams);

    //如果请求成功，将数据返回出去
    if (result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE) {
      return WeatherWarningBean.fromJson(result.data);
    }
    //数据请求失败，返回空
    return null;
  }

  //请求空气质量信息
  Future<WeatherAirQualityBean?> getWeatherAirQualityInfo(String location) async{
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String, dynamic> queryParams = Map();
    //设置location
    queryParams[DioNetConstant.REQUEST_WEATHER_LOCATION] = location;
    //开始请求
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_AIR_QUALITY, queryParams);

    //如果请求成功，将数据返回出去
    if (result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE) {
      return WeatherAirQualityBean.fromJson(result.data);
    }
    //数据请求失败，返回空
    return null;
  }
}
