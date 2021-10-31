import 'package:today/base/base_model.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/ui/weather/home/weather_home_route.dart';

///天气首页mvp模式实现
class WeatherHomePresenter
    extends BasePresenter<_WeatherHomeModel, WeatherHomeState> {
  //构造函数
  WeatherHomePresenter(WeatherHomeState view)
      : super(_WeatherHomeModel(), view);

  ///页面中的initState()方法执行之后会执行到这里
  ///根据cityId判断是否应该获取当前位置的信息
  void initState() async {

  }

}

///天气首页mvp模式实现
class _WeatherHomeModel extends BaseModel {}
