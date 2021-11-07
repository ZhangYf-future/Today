import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/comm/db_result_bean.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/constact/constact_dio.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/event/event_weather.dart';
import 'package:today/net/http_weather_helper.dart';
import 'package:today/ui/weather/city_add/city_add_route.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/log_utils.dart';
import 'package:today/utils/string_utils.dart';

///添加城市信息的mvp模式

class CityAddPresenter extends BasePresenter<CityAddModel, CityAddState> {
  //记录上一次请求的数据
  String? _oldCityName = null;

  CityAddPresenter(CityAddState view) : super(CityAddModel(), view);

  //请求获取城市列表
  Future<void> queryCityList(String name) async {
    //如果这一次的和上一次的一样，则不请求数据
    if (_oldCityName == name) {
      Logs.ez("old city name is current name,do not request");
      return;
    }

    if (StringUtils.isEmpty(name)) {
      this.view.showMessage(StringConstant.INPUT_SEARCH_CITY_NAME);
      return;
    }
    //开始请求之前，记录当前的请求数据，防止发起重复请求
    _oldCityName = name;
    final result = await this.model.queryCityList(name);
    if (result == null ||
        result.code != DioNetConstant.WEATHER_HTTP_SUCCESS_CODE.toString()) {
      this.view.showMessage(StringConstant.REQUEST_DATA_ERROR);
      //数据请求失败，将标记设置为空，方便下一次请求
      _oldCityName = null;
      return;
    }
    this.view.requestCityListSuccess(result);
  }

  ///将标记重置为空
  void clearOldName() {
    _oldCityName = null;
  }

  //插入选中的数据到数据库中
  void insertCityBean(WeatherCityBean bean) async {
    final result = await this.model.insertCity(bean);
    if (result.code == DBConstant.DB_RESULT_FAILED) {
      if (result.result is WeatherCityDBBean &&
          (result.result as WeatherCityDBBean).hfId == bean.id) {
        weatherCityEvent.notifyCityRepeatAddEvent(bean);
        this.view.showMessage(StringConstant.CURRENT_CITY_ADDED);
        this.view.exit();
        return;
      }
      //插入数据失败
      this.view.showMessage(StringConstant.INSERT_DATA_ERROR);
      return;
    }
    //插入数据成功
    weatherCityEvent.notifyCityAddEvent(bean);
    this.view.showMessage(StringConstant.SAVE_CITY_SUCCESS);
    this.view.exit();
  }
}

class CityAddModel extends BaseModel {
  //请求搜索城市信息的结果
  Future<WeatherCityListBean?> queryCityList(String name) async {
    return await weatherHelper.queryCityList(name);
  }

  //请求将选中的城市信息添加到本地数据库中
  Future<DBResultEntity> insertCity(WeatherCityBean bean) async {
    return await DBHelper()
        .insertWeatherCity(WeatherCityDBBean.fromOther(bean));
  }
}
