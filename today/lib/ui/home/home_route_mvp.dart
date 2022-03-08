import 'package:permission_handler/permission_handler.dart';
import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/constact/constant_string.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/net/http_weather_helper.dart';
import 'package:today/ui/home/home_route.dart';
import 'package:today/utils/constant.dart';
import 'package:today/constact/constant_string.dart' as cs;
import 'package:shared_preferences/shared_preferences.dart';

//presenter
class HomeRoutePresenter extends BasePresenter<HomeRouteModel, HomeState> {
  HomeRoutePresenter(HomeState view) : super(HomeRouteModel(), view);

  //获取首页列表数据
  List<HomeBlockBean> getHomeBlocks() => this.model.createHomeBlocks();

  //获取当前位置的实时天气信息
  void getNowWeather() async {
    final list = List<Permission>.empty(growable: true);
    list.add(Permission.location);
    list.add(Permission.storage);

    // if (!await PermissionUtils.checkHavePermissions(list)) {
    //   //没有权限，请求这两个权限
    //   if (!await PermissionUtils.requestPermissions(list)) {
    //     //没有请求到权限，直接返回空值
    //     return;
    //   }
    // }
    // //有权限，获取当前的位置信息
    // final locationUtils = BDLocationUtils();
    // Logs.ez("location utils is:${locationUtils.runtimeType}");
    // locationUtils.getLocation((event) async {
    //   if (event != null && !event.containsKey("errorCode")) {
    //     Logs.ez("定位成功");
    //     //结束定位
    //     locationUtils.stopLocation();
    //     //转换位置信息
    //     BaiduLocation location = BaiduLocation.fromMap(event);
    //     final weather = await this
    //         .model
    //         .getNowWeather("${location.longitude},${location.latitude}");
    //     //将位置信息设置进去
    //     weather.location = location;
    //     this.view.loadNowWeatherSuccess(weather);
    //   }
    // });
  }

  //获取今天已经消费的数量
  Future<double> getBillCountToday() => this.model.getBillCountToday();

  //判断是否显示过隐私协议的弹框
  Future<bool> checkShowedPravicyDialog() =>
      this.model.checkShowedPrivacyDialog();

  //设置已经显示过隐私协议了
  void setShowedPrivacyAgreement() => this.model.setShowedPrivacyAgreement();
}

//Model
class HomeRouteModel extends BaseModel<HomeRoutePresenter> {
  //创建首页需要的数据
  List<HomeBlockBean> createHomeBlocks() {
    //创建一个列表用于存放最终的数据
    final List<HomeBlockBean> homeBlockList = List.empty(growable: true);

    //第一个是账单类型
    final HomeBlockBean billBean = new HomeBlockBean(
        HomeBlockConstant.HOME_BLOCK_TYPE_BILL,
        HomeBlockConstant.HOME_BLOCK_NAME_BILL,
        cs.StringConstant.HOME_BLOCK_TITLE_BILL,
        null);

    //天气类型
    final HomeBlockBean weatherBean = new HomeBlockBean(
        HomeBlockConstant.HOME_BLOCK_TYPE_WEATHER,
        HomeBlockConstant.HOME_BLOCK_NAME_WEATHER,
        HomeBlockConstant.HOME_BLOCK_TITLE_WEATHER_NO_ADDRESS,
        null);

    homeBlockList.add(billBean);
    homeBlockList.add(weatherBean);

    return homeBlockList;
  }

  //获取当前位置的实时天气信息
  //locationInfo可以是经纬度，也可以是位置id，位置id可以从和风天气API处获得
  Future<WeatherNowBean> getNowWeather(String locationInfo) async {
    return await weatherHelper.getWeatherNow(locationInfo);
  }

  //获取今天已经消费的金额
  Future<double> getBillCountToday() async {
    return await DBHelper().getTodayBillCount();
  }

  //判断是否显示过隐私协议的弹框
  Future<bool> checkShowedPrivacyDialog() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    final bool? result =
        pre.getBool(StringConstant.KEY_SHOWED_PRIVACY_AGREEMENT);
    return Future.value(result ?? false);
  }

  //设置已经显示过隐私协议了
  void setShowedPrivacyAgreement() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setBool(StringConstant.KEY_SHOWED_PRIVACY_AGREEMENT, true);
  }
}
