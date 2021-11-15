import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/bean/weather/weather_hour_bean.dart';
import 'package:today/bean/weather/weather_life_bean.dart';
import 'package:today/bean/weather/weather_now_bean.dart';
import 'package:today/bean/weather/weather_seven_day_bean.dart';
import 'package:today/bean/weather/weather_warning_bean.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/net/http_weather_helper.dart';
import 'package:today/ui/weather/home/weather_info_widget.dart';
import 'package:today/utils/date_utils.dart';

class WeatherInfoPresenter extends BasePresenter<WeatherInfoModel,WeatherInfoState>{

  //上一次请求的城市信息
  String? _oldCityInfo;

  //上一次发起请求的时间
  int _oldRequestTime = 0;
  
  WeatherInfoPresenter(WeatherInfoState view) : super(WeatherInfoModel(), view);

  //根据城市信息请求当前城市的实时天气
  void getWeatherNowInfo(String cityInfo) async{
      //如果这次的城市信息和上次的城市信息一样，并且时间小于20分钟，则不会发起请求。
      if(cityInfo == _oldCityInfo && !DateUtils.checkMoreThan20Minutes(_oldRequestTime)){
        //直接退出，不会发起请求
        this.view.showMessage(StringConstant.DO_NOT_ALWAYS_REQUEST);
        return;
      }
      _oldCityInfo = cityInfo;
      _oldRequestTime = DateTime.now().millisecondsSinceEpoch;
      final WeatherNowBean? result =  await this.model.getWeatherInfo(cityInfo);
      if(checkHttpResult(result,result?.now)){
        //数据请求成功,回调到页面中设置数据
        this.view.requestWeatherNowSuccess(result!);

        //接着请求逐小时天气信息
        _getWeatherHourInfo(cityInfo);

        //请求未来七天天气预报
        _getWeatherSevenDay(cityInfo);

        //请求生活指数信息
        _getWeatherLifeInfo(cityInfo);

        //请求报警信息
        _getWeatherWarningInfo(cityInfo);
      }else{
        //数据请求失败
        _oldCityInfo = null;
        _oldRequestTime = 0;
      }
  }

  //请求逐小时天气信息
  void _getWeatherHourInfo(String cityInfo) async{
    final WeatherHourBean? result = await this.model.getWeatherHourInfo(cityInfo);
    if(checkHttpResult(result, result?.hourly)){
      //数据请求成功
      this.view.requestWeatherHourSuccess(result!);
    }
  }

  //请求未来七天天气预报
  void _getWeatherSevenDay(String cityInfo) async{
    final WeatherSevenDayBean? result = await this.model.getWeatherSevenDay(cityInfo);
    if(checkHttpResult(result, result?.daily)){
      //数据请求成功
      this.view.requestWeatherSevenDay(result!);
    }
  }

  //请求当天的生活指数
  void _getWeatherLifeInfo(String cityInfo) async{
    final WeatherLifeBean? result = await this.model.getWeatherLifeInfo(cityInfo);
    if(checkHttpResult(result, result?.daily)){
      //数据请求成功
      this.view.requestWeatherLifeSuccess(result!);
    }
  }

  //请求当天的报警信息
  void _getWeatherWarningInfo(String cityInfo) async{
    final WeatherWarningBean? result = await this.model.getWeatherWarningInfo(cityInfo);
    if(checkHttpResult(result, result?.warning)){
      //数据请求成功
    }
  }
}


class WeatherInfoModel extends BaseModel<WeatherInfoPresenter>{

  //请求城市天气信息
  Future<WeatherNowBean> getWeatherInfo(String cityInfo) {
    return weatherHelper.getWeatherNow(cityInfo);
  }

  //请求逐小时天气信息
  Future<WeatherHourBean?> getWeatherHourInfo(String cityInfo) => weatherHelper.getWeatherHour(cityInfo); 

  //请求未来七天天气预报
  Future<WeatherSevenDayBean?> getWeatherSevenDay(String cityInfo) => weatherHelper.getWeatherSevenDay(cityInfo);

  //请求当天的生活指数
  Future<WeatherLifeBean?> getWeatherLifeInfo(String cityInfo) => weatherHelper.getWeatherLifeInfo(cityInfo);

  //请求当天的报警信息
  Future<WeatherWarningBean?> getWeatherWarningInfo(String cityInfo) => weatherHelper.getWeatherWarningInfo(cityInfo);
}