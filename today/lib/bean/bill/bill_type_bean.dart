import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';

///账单类型数据类

class BillTypeBean {
  int id;
  String name;
  String remark;
  String createTime;
  int weight;

  BillTypeBean();

  //从Map中获取数据
  BillTypeBean.fromMap(Map<String, dynamic> map) {
    this.id = map[DBConstant.BILL_TYPE_ID];
    this.name = map[DBConstant.BILL_TYPE_NAME];
    this.remark = map[DBConstant.BILL_TYPE_REMARK];
    this.createTime = map[DBConstant.BILL_TYPE_CREATE_TIME];
    this.weight = map[DBConstant.BILL_TYPE_WEIGHT];
  }

  //将当前数据转换为数据库map
  //由于其中的id设置为了自动增长，所以这里的id传null
  Map<String, dynamic> parseInsertDBMap() {
    Map<String, dynamic> map = Map();
    map[DBConstant.BILL_TYPE_ID] = null;
    map[DBConstant.BILL_TYPE_NAME] = name;
    map[DBConstant.BILL_TYPE_REMARK] = remark;
    String time = DateUtils.getCurrentTime();
    map[DBConstant.BILL_TYPE_CREATE_TIME] = time;
    map[DBConstant.BILL_TYPE_WEIGHT] = weight == null ? 0 : weight;
    return map;
  }

  //更新数据时，将当前数据转换为数据库map
  Map<String, dynamic> parseUpdateDBMap() {
    Map<String, dynamic> map = Map();
    map[DBConstant.BILL_TYPE_ID] = id;
    map[DBConstant.BILL_TYPE_NAME] = name;
    map[DBConstant.BILL_TYPE_REMARK] = remark;
    String time = DateUtils.getCurrentTime();
    map[DBConstant.BILL_TYPE_CREATE_TIME] = time;
    map[DBConstant.BILL_TYPE_WEIGHT] = weight == null ? 0 : weight;
    return map;
  }
}
