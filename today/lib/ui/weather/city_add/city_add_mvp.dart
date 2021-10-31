import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/weather/weather_city_bean.dart';
import 'package:today/net/http_weather_helper.dart';
import 'package:today/ui/weather/city_add/city_add_route.dart';
import 'package:today/utils/string_utils.dart';

///添加城市信息的mvp模式

class CityAddPresenter extends BasePresenter<CityAddModel,CityAddState>{
  
  CityAddPresenter( CityAddState view) : super(CityAddModel(), view);

  //请求获取城市列表
  Future<WeatherCityListBean?> queryCityList(String name) async{
    if(StringUtils.isEmpty(name)){
      this.view.showMessage("请输入要查询的城市名称");
      return null;
    }
    final result = await this.model.queryCityList(name);
    if(result == null){
      this.view.showMessage("数据请求充错，请稍后重试");
    }
    return result;
  }

}

class CityAddModel extends BaseModel{

  //请求搜索城市信息的结果
  Future<WeatherCityListBean?> queryCityList(String name) async {
    return await weatherHelper.queryCityList(name);
  }
}