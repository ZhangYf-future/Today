import 'package:permission_handler/permission_handler.dart';
import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/main.dart';
import 'package:today/net/http_weather_helper.dart';
import 'package:today/ui/weather/home/weather_home_route.dart';
import 'package:today/utils/location_utils.dart';

///天气首页mvp模式实现
class WeatherHomePresenter
    extends BasePresenter<_WeatherHomeModel, WeatherHomeState> {
  //构造函数
  WeatherHomePresenter(WeatherHomeState view)
      : super(_WeatherHomeModel(), view);

  //页面进入到initState()方法之后调用这个方法将需要操作的逻辑传递进来
  void initState() async {
    //判断当前的地理位置开关是否打开

    //其实location包下也提供了请求地理位置权限的方法，但是这里是使用permission_handler包下的方法

    var haveLocationPermission = await checkLocationPermission();
    if (!haveLocationPermission) {
      //请求权限
      var status = await requestLocationPermission();
      haveLocationPermission = (status != PermissionStatus.denied);
    }

    var haveExtraStoragePermission = await checkExtraStoragePermission();
    if (!haveExtraStoragePermission) {
      var status = await requestExtraStoragePersmission();
      haveExtraStoragePermission = (status != PermissionStatus.denied);
    }

    //最终判断是否请求到权限
    if (!haveExtraStoragePermission || !haveLocationPermission) {
      //没有权限退出当前页
      view.exit();
      return;
    }
    //已经获取到权限
    //getLocation();
    //请求实时天气
    WeatherNowBean weatherNowBean =
        await weatherHelper.getWeatherNow("108.95,34.272");
    showInfo("今日温度:${weatherNowBean.now.temp}");
  }

  //请求地理位置权限
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  //请求存储卡权限
  Future<PermissionStatus> requestExtraStoragePersmission() async {
    return await Permission.storage.request();
  }

  //判断是否有地理位置权限
  Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  //判断是否拥有存储卡权限
  Future<bool> checkExtraStoragePermission() async {
    var status = await Permission.storage.status;
    return status == PermissionStatus.granted;
  }

  //权限请求到之后获取用户的位置
  void getLocation() {
    AMapLocationUtils().getLocation();
  }
}

///天气首页mvp模式实现
class _WeatherHomeModel extends BaseModel {}
