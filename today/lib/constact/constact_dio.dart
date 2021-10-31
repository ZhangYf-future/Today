//网络部分的常量信息
class DioNetConstant {
  //和风天气的错误码
  static const WEATHER_HTTP_SUCCESS_CODE = 200;

  //和风天气key
  static const WEATHER_HTTP_KEY = "ec18237abdd64ff6a5227d8ac93e7f18";

  //获取天气的基地址
  static const DIO_BASE_URL_WEATHER = "https://devapi.qweather.com";
  //获取城市位置信息的基地址
  static const DIO_BASE_URL_WEATHER_CITY = "https://geoapi.qweather.com";

  //获取实时天气的路径
  static const PATH_GET_WEATHER_NOW = "/v7/weather/now";
  //请求搜索天气列表的路径
  static const PATH_GET_SEARCH_CITY_LIST = "/v2/city/lookup";
}