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
  //逐小时天气请求路径
  static const PATH_GET_WEATHER_HOUR = "/v7/weather/24h";
  //未来七天天气预报路径
  static const PATH_GET_WEATHER_SEVEN_DAY = "/v7/weather/7d";
  //获取生活指数的路径
  static const PATH_GET_WEATHER_LIFE = "/v7/indices/1d";
  //获取天气灾害预警信息的路径
  static const PATH_GET_WEATHER_WARNING = "/v7/warning/now";
  //获取空气质量信息
  static const PATH_GET_AIR_QUALITY = "/v7/air/now";

  //location
  static const REQUEST_WEATHER_LOCATION = "location";
  //type
  static const REQUEST_WEATHER_TYPE = "type";
}