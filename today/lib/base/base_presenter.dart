import 'package:today/base/base_model.dart';
import 'package:today/base/base_view.dart';
import 'package:today/bean/comm/base_http_result_bean.dart';
import 'package:today/constact/constact_dio.dart';
import 'package:today/constact/constact_string.dart';

abstract class BasePresenter<M extends BaseModel, V extends BaseView> {
  final M model;
  
  final V view;

  BasePresenter(this.model,this.view) {
    this.model.attach(this);
  }

  //对请求到的数据进行统一的处理
  bool checkHttpResult(final BaseHttpBean? result,Object? data,{bool showToast = true,bool checkData = true}){

      if(result == null || (checkData && data == null)){
        //数据请求出错
        if(showToast){
          this.view.showMessage(StringConstant.REQUEST_DATA_ERROR);
        }
        return false;
      }

      if(result.code != null && result.code == DioNetConstant.WEATHER_HTTP_SUCCESS_CODE.toString()){
        //数据请求成功
        return true;
      }

      //数据请求失败
      if(result.message != null && showToast){
        this.view.showMessage(result.message!);
        return false;
      }

      //数据请求失败
      if(showToast){
        this.view.showMessage(StringConstant.REQUEST_DATA_ERROR);
      }
      return false;

  }
}
