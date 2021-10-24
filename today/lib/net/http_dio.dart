import 'package:dio/dio.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/log_utils.dart';

///dio实例
final Dio dio = Dio();

///和dio相关的工具类
class DioUtils {
  //设置dio相关的配置
  static void dioConfig() {
    //天气添加默认的header
    final Map<String, String> headers = Map();

    //网络配置信息
    final BaseOptions options = BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 30 * 1000,
        sendTimeout: 30 * 1000,
        baseUrl: DioNetConstant.DIO_BASE_URL_WEATHER,
        headers: headers);

    //将配置信息设置进去
    dio.options = options;

    //设置拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, requestHandler) {
      //将和风天气的key添加到请求参数中
      if (options.queryParameters == null) {
        options.queryParameters = Map();
      }
      options.queryParameters["key"] = DioNetConstant.WEATHER_HTTP_KEY;
      return requestHandler.next(options);
    }));
  }

  //发起一个get请求
  static Future<Response<T>> getResponse<T>(
      String path, Map<String, dynamic> headers) async {
    return await dio.get(path, queryParameters: headers);
  }
}
