import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    Logs.ez("will start get location");
    _locationPlugin.onLocationChanged().listen((map) {
      map.forEach((key, value) {
        Logs.ez("getLocation:location info:$key -- $value");
        Fluttertoast.showToast(msg: "key is: $key,value is $value");
      });
      //_locationPlugin.stopLocation();
    });
    //开始定位
    _locationPlugin.startLocation();
  }
}

///百度地图定位
class BDLocationUtils {
  //单例
  static BDLocationUtils _instance = BDLocationUtils._internal();

  BDLocationUtils._internal();

  factory BDLocationUtils() => _instance;

  //执行定位的插件
  final LocationFlutterPlugin _plugin = LocationFlutterPlugin();

  //配置信息
  void _setUpLocation() {
    /// android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(false); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(0); // 设置发起定位请求时间间隔,设置为0表示只执行一次定位

    Map androidMap = androidOption.getMap();

    /// ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType(
        "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _plugin.prepareLoc(androidMap, iosMap);
  }

  //获取位置信息
  void getLocation(void Function(Map<String, Object>?)? callback) {
    _plugin.onResultCallback().listen(callback);
    _setUpLocation();
    _plugin.startLocation();
  }

  //停止定位
  void stopLocation() {
    _plugin.stopLocation();
  }
}
