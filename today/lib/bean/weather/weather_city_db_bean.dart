import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/utils/constant.dart';

///天气城市信息在数据库中的数据
class WeatherCityDBBean {
  //id
  int? id;
  //和风天气的id
  String hfId;
  //详细地址
  String address;
  //城市名称
  String name;
  //区域信息
  String region;
  //是否是定位信息，默认不是
  bool isLocation = false;

  WeatherCityDBBean(this.hfId, this.address, this.name, this.region);

  factory WeatherCityDBBean.fromOther(WeatherCityBean bean) =>
      WeatherCityDBBean(
          bean.id,
          "${bean.country}${bean.adm1}${bean.adm2}${bean.name}",
          bean.adm2,
          bean.name);

  ///从Map中获取当前数据对象
  factory WeatherCityDBBean.fromMap(Map<String, dynamic> map) {
    WeatherCityDBBean bean = new WeatherCityDBBean(
        map[DBConstant.TABLE_WEATHER_CITY_HF_ID] as String,
        map[DBConstant.TABLE_WEATHER_CITY_ADDRESS] as String,
        map[DBConstant.TABLE_WEATHER_CITY_NAME] as String,
        map[DBConstant.TABLE_WEATHER_CITY_REGION] as String);
    bean.id = map[DBConstant.TABLE_WEATHER_CITY_ID] as int;

    return bean;
  }

  ///从百度地图定位中生成当前类的对象
  // factory WeatherCityDBBean.fromBDLocation(BaiduLocation location) {
  //   WeatherCityDBBean bean = WeatherCityDBBean(
  //       "${location.longitude},${location.latitude}",
  //       "${location.country}${location.province}${location.city}${location.address}",
  //       location.city ?? "",
  //       location.district ?? "");
  //   bean.isLocation = true;
  //   return bean;
  // }

  //将当前的数据转换为Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    if (id != null) {
      map[DBConstant.TABLE_WEATHER_CITY_ID] = id;
    }
    map[DBConstant.TABLE_WEATHER_CITY_HF_ID] = hfId;
    map[DBConstant.TABLE_WEATHER_CITY_ADDRESS] = address;
    map[DBConstant.TABLE_WEATHER_CITY_NAME] = name;
    map[DBConstant.TABLE_WEATHER_CITY_REGION] = region;
    return map;
  }
}
