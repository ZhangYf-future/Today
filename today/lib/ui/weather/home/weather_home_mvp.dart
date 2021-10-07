import 'package:permission_handler/permission_handler.dart';
import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/ui/weather/home/weather_home_route.dart';

///天气首页mvp模式实现
class WeatherHomePresenter
    extends BasePresenter<_WeatherHomeModel, WeatherHomeState> {
  //构造函数
  WeatherHomePresenter(WeatherHomeState view) : super(view);

  //创建Model
  @override
  _WeatherHomeModel createModel() => _WeatherHomeModel();

  //页面进入到initState()方法之后调用这个方法将需要操作的逻辑传递进来
  void initState() async {
    var haveLocationPermission = await checkLocationPermission();
    if (!haveLocationPermission) {
      //请求权限
      var status = await requestLocationPermission();
      haveLocationPermission = (status != PermissionStatus.denied);
    }
    print("final we have permision is:$haveLocationPermission");
  }

  //请求地理位置权限
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  //判断是否有地理位置权限
  Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }
}

///天气首页mvp模式实现
class _WeatherHomeModel extends BaseModel {}
