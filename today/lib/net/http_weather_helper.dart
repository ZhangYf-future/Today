import 'package:dio/dio.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/net/http_dio.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/log_utils.dart';

var weatherHelper = WeatherHttpHelper();

class WeatherHttpHelper {
  //获取实时天气
  Future<WeatherNowBean> getWeatherNow(String location) async {
    final Map<String, dynamic> queryParams = Map();
    queryParams["location"] = location;
    Response result = await DioUtils.getResponse(
        DioNetConstant.PATH_GET_WEATHER_NOW, queryParams);
    return WeatherNowBean.fromJson(result.data);
  }
}
