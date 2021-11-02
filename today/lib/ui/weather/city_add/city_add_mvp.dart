import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/comm/db_result_bean.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/constact/constact_dio.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/net/http_weather_helper.dart';
import 'package:today/ui/weather/city_add/city_add_route.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/string_utils.dart';

///添加城市信息的mvp模式

class CityAddPresenter extends BasePresenter<CityAddModel,CityAddState>{
  
  CityAddPresenter( CityAddState view) : super(CityAddModel(), view);

  //请求获取城市列表
  Future<void> queryCityList(String name) async{
    if(StringUtils.isEmpty(name)){
      this.view.showMessage(StringConstant.INPUT_SEARCH_CITY_NAME);
      return;
    }
    final result = await this.model.queryCityList(name);
    if(result == null || result.code != DioNetConstant.WEATHER_HTTP_SUCCESS_CODE.toString()){
      this.view.showMessage(StringConstant.REQUEST_DATA_ERROR);
      return;
    }
    this.view.requestCityListSuccess(result);
  }

  //插入选中的数据到数据库中
  void insertCityBean(WeatherCityBean bean) async{
    final result = await this.model.insertCity(bean);
    if(result.code == DBConstant.DB_RESULT_FAILED){
      //插入数据失败
      this.view.showMessage(StringConstant.INSERT_DATA_ERROR);
      return;
    }
    //插入数据成功
    this.view.showMessage(StringConstant.SAVE_CITY_SUCCESS);
    this.view.exit();
  }

}

class CityAddModel extends BaseModel{

  //请求搜索城市信息的结果
  Future<WeatherCityListBean?> queryCityList(String name) async {
    return await weatherHelper.queryCityList(name);
  }

  //请求将选中的城市信息添加到本地数据库中
  Future<DBResultEntity> insertCity(WeatherCityBean bean) async{
    return await DBHelper().insertWeatherCity(WeatherCityDBBean.fromOther(bean));
  }
}