import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/comm/db_result_bean.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/db/db_helper.dart';
import 'package:today/event/event_weather.dart';
import 'package:today/ui/weather/city_manage/city_manage_route.dart';
import 'package:today/utils/constant.dart';

///城市管理逻辑和数据页面

class CityManagePresenter
    extends BasePresenter<CityManageModel, CityManageState> {

  CityManagePresenter(CityManageState view)
      : super(CityManageModel(), view);

  
  //请求全部城市列表
  void getAllCityList() async{
      var result = await this.model.getAllCityList();
      this.view.requestCityListSuccess(result);
  }

  //删除指定的城市信息
  void deleteWeatherCity(int id,String hfid) async{
    final result = await this.model.deleteWeatherCity(id);
    if(result.code == DBConstant.DB_RESULT_SUCCESS){
      this.view.deleteCitySuccess();
      //将事件通知到外部
      weatherCityEvent.notifyCityRemovedEvent(hfid);
      //退出当前页面
      this.view.exit();
    }else{
      this.view.showMessage(result.msg);
    }
  }
}

class CityManageModel extends BaseModel<CityManagePresenter> {

  //获取城市列表
 Future<List<WeatherCityDBBean>> getAllCityList()  => DBHelper().getAllWeatherCityList();

 //删除城市信息
 Future<DBResultEntity> deleteWeatherCity(int id) => DBHelper().deleteWeatherCityWithId(id);

}
