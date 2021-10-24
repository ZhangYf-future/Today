import 'dart:async';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:today/utils/log_utils.dart';

///高德地图定位
class AMapLocationUtils {
  //定位参数
  final AMapLocationOption _option = AMapLocationOption();
  //定位插件
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();

  AMapLocationUtils() {
    //设置基本的定位参数
    //设置单次定位
    _option.onceLocation = true;
    //设置需要返回逆地理信息
    _option.needAddress = true;
    //设置定位模式
    _option.locationMode = AMapLocationMode.Battery_Saving;
    //将定位参数设置给定位插件
    _locationPlugin.setLocationOption(_option);
  }

  //获取定位位置
  void getLocation() {
    _locationPlugin.onLocationChanged().listen((map) {
      map.forEach((key, value) {
        Logs.ez("getLocation:location info:$key -- $value");
      });
      _locationPlugin.stopLocation();
    });
    //开始定位
    _locationPlugin.startLocation();
  }
}
