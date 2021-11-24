import 'package:today/bean/weather/weather_city_bean.dart';

///天气相关的事件
final WeatherCityEvent weatherCityEvent = WeatherCityEvent();
///城市被添加到数据库中的事件
typedef void WeatherCityAdded(WeatherCityBean bean);

//某一个城市被重复添加到数据库
typedef void WeatherCityRepeatAdded(WeatherCityBean bean);

//某一个城市被从数据库中删除
typedef void WeatherCityRemoved(String hfId);

class WeatherCityEvent {
  static WeatherCityEvent _instance = WeatherCityEvent._internal();

  ///私有构造函数
  WeatherCityEvent._internal();

  //工厂构造函数，外部使用
  factory WeatherCityEvent() => _instance;

  //保存城市添加事件的map
  final List<WeatherCityAdded> _cityAddList = [];
  //保存城市重复添加事件的map
  final List<WeatherCityRepeatAdded> _cityRepeatAddList = [];
  //保存城市被删除的事件
  final List<WeatherCityRemoved> _cityRemovedEventList = [];

  //将【添加城市】事件添加到事件列表中
  void addCityAddedEvent(WeatherCityAdded event) {
    if (!_cityAddList.contains(event)) {
      _cityAddList.add(event);
    }
  }

  //移除【添加城市】事件
  void removeCityAddedEvent(WeatherCityAdded event) {
    if(_cityAddList.contains(event)){
      _cityAddList.remove(event);
    }
  }

  //通知【添加城市】事件
  void notifyCityAddEvent(WeatherCityBean bean){
    if(_cityAddList.isNotEmpty){
      for(WeatherCityAdded event in _cityAddList){
        event.call(bean);
      }
    }
  }


  //将【重复添加城市】事件添加到事件列表中
  void addCityRepeatAddedEvent(WeatherCityRepeatAdded event) {
    if (!_cityRepeatAddList.contains(event)) {
      _cityRepeatAddList.add(event);
    }
  }

  //移除【重复添加城市】事件
  void removeCityRepeatAddedEvent(WeatherCityRepeatAdded event) {
    if(_cityRepeatAddList.contains(event)){
      _cityRepeatAddList.remove(event);
    }
  }

  //通知【重复添加城市】事件
  void notifyCityRepeatAddEvent(WeatherCityBean bean){
    if(_cityRepeatAddList.isNotEmpty){
      for(WeatherCityRepeatAdded event in _cityRepeatAddList){
        event(bean);
      }
    }
  }


    //将【删除城市】事件添加到事件列表中
  void addCityRemovedEvent(WeatherCityRemoved event) {
    if (!_cityRemovedEventList.contains(event)) {
      _cityRemovedEventList.add(event);
    }
  }

  //移除【重复添加城市】事件
  void removeCityRemovedEvent(WeatherCityRemoved event) {
    if(_cityRemovedEventList.contains(event)){
      _cityRemovedEventList.remove(event);
    }
  }

  //通知【重复添加城市】事件
  void notifyCityRemovedEvent(String hfid){
    if(_cityRemovedEventList.isNotEmpty){
      for(WeatherCityRemoved event in _cityRemovedEventList){
        event(hfid);
      }
    }
  }
}
