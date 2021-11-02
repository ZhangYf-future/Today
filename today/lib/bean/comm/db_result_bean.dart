import 'package:today/utils/constant.dart';

///对数据库操作的结果信息
class DBResultEntity {
  //错误码,默认操作成功
  int code = DBConstant.DB_RESULT_SUCCESS;
  //提示信息
  String msg = "";
  //返回值
  dynamic result;
}
