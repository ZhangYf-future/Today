import 'package:today/utils/constant.dart';

class BillPlanBean {
  BillPlanBean();

  BillPlanBean.fromMap(Map<String, dynamic> map) {
    this.id = map[DBConstant.BILL_PLAN_ID];
    this.planAmount = map[DBConstant.BILL_PLAN_AMOUNT];
    this.planYear = map[DBConstant.BILL_PLAN_YEAR];
    this.planMonth = map[DBConstant.BILL_PLAN_MONTH];
    this.createTime = map[DBConstant.BILL_PLAN_CREATE_TIME];
  }

  int id;
  double planAmount;
  int planYear;
  int planMonth;
  String createTime;

  //将当前类中的数据转换成Map保存在数据库中
  //id将会自动生成，传空即可
  Map<String, dynamic> insertDB() {
    Map<String, dynamic> data = Map();
    data[DBConstant.BILL_PLAN_ID] = null;
    data[DBConstant.BILL_PLAN_AMOUNT] = this.planAmount;
    data[DBConstant.BILL_PLAN_YEAR] = this.planYear;
    data[DBConstant.BILL_PLAN_MONTH] = this.planMonth;
    data[DBConstant.BILL_PLAN_CREATE_TIME] = this.createTime;
    return data;
  }

  //判断传入的时间和当前时间是否相同
  bool checkDateEquals(int year, int month) {
    return this.planYear == year && this.planMonth == month;
  }
}
