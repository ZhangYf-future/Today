import 'package:permission_handler/permission_handler.dart';
import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';

import 'package:today/db/db_helper.dart';

import 'package:today/ui/weather/home/weather_home_route.dart';

import 'package:today/utils/log_utils.dart';
import 'package:today/utils/permission_utils.dart';

///天气首页mvp模式实现
class WeatherHomePresenter
    extends BasePresenter<_WeatherHomeModel, WeatherHomeState> {
  //构造函数
  WeatherHomePresenter(WeatherHomeState view)
      : super(_WeatherHomeModel(), view);

  ///页面中的initState()方法执行之后会执行到这里
  ///根据cityId判断是否应该获取当前位置的信息
  void getLocation() async {
    //首先判断是否用于定位和读写文件的权限
    final permissionList = List<Permission>.empty(growable: true);
    permissionList.add(Permission.location);
    permissionList.add(Permission.storage);

    if (!await PermissionUtils.checkHavePermissions(permissionList)) {
      Logs.ez("没有权限");
      //没有相应的权限，首先请求这两个权限
      if (!await PermissionUtils.requestPermissions(permissionList)) {
        //没有请求到权限信息，直接退出
        Logs.ez("没有请求到权限");
        this.view.getLocationFailed();
        return;
      }
    }
    //有权限信息，获取位置
    _getLocation();
  }

  //请求城市信息
  void _getLocation() {
    // BDLocationUtils utils = BDLocationUtils();
    // utils.getLocation((data) {
    //   utils.stopLocation();
    //   if (data != null && !data.containsKey("errorCode")) {
    //     //定位成功
    //     var location = BaiduLocation.fromMap(data);
    //     var bean = WeatherCityDBBean.fromBDLocation(location);
    //     this.view.getLocationSuccess(bean);
    //   } else {
    //     //定位失败
    //     this.view.getLocationFailed();
    //   }
    // });
  }

  //请求全部的城市信息
  Future<List<WeatherCityDBBean>> getAllCityList() =>
      DBHelper().getAllWeatherCityList();

  //判断当前被重复添加的城市在整个页面的第几个位置
  int checkRepeatCityPosition(
      List<WeatherCityDBBean>? sourceList, WeatherCityBean cityBean) {
    if (sourceList == null || sourceList.isEmpty) {
      return -1;
    }
    for (int i = 0; i < sourceList.length; i++) {
      if (sourceList[i].hfId == cityBean.id) {
        return i;
      }
    }
    return -1;
  }
}

///天气首页mvp模式实现
class _WeatherHomeModel extends BaseModel {}
