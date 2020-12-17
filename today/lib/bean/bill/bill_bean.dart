import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/bean/bill/bill_type_bean.dart';

/// 账单管理数据类

class BillBean {
  int id;
  double amount; //金额
  int time; //时间
  String timeFormat; //格式化后的时间
  String address; //位置
  String remark; //备注
  bool isPay; //是否是支出
  BillTypeBean billTypeBean; //类型信息
  BillPlanBean billPlanBean; //计划信息
}
