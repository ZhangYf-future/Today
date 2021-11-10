import 'package:dio/dio.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/bean/weather/weather_hour_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
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
  Future<WeatherHourBean?> getWeatherHour(String location) async{
    //设置基地址
    dio.options.baseUrl = DioNetConstant.DIO_BASE_URL_WEATHER;
    //设置请求参数
    final Map<String,dynamic> queryParams = Map();
    queryParams[DioNetConstant.REQUEST_WEATHER_LOCATION] = location;
    //开始请求
    Response result = await DioUtils.getResponse(DioNetConstant.PATH_GET_WEATHER_HOUR, queryParams);

    if(result.statusCode == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE){
      return WeatherHourBean.fromJson(result.data);
    }
    return null;
  }
}
