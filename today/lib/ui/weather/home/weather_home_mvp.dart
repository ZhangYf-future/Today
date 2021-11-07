import 'package:permission_handler/permission_handler.dart';
import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/ui/weather/home/weather_home_route.dart';
import 'package:today/utils/permission_utils.dart';

///天气首页mvp模式实现
class WeatherHomePresenter
    extends BasePresenter<_WeatherHomeModel, WeatherHomeState> {
  //构造函数
  WeatherHomePresenter(WeatherHomeState view)
      : super(_WeatherHomeModel(), view);

  ///页面中的initState()方法执行之后会执行到这里
  ///根据cityId判断是否应该获取当前位置的信息
  void initState() async {
    //首先判断是否用于定位和读写文件的权限
    final permissionList = List<Permission>.empty(growable: true);
    permissionList.add(Permission.location);
    permissionList.add(Permission.storage);
    
    if(!await PermissionUtils.checkHavePermissions(permissionList)){

      //没有相应的权限，首先请求这两个权限
      if(!await PermissionUtils.requestPermissions(permissionList)){

        //没有请求到相应的权限

      }
      
    }
    
    
  }

}

///天气首页mvp模式实现
class _WeatherHomeModel extends BaseModel {}
