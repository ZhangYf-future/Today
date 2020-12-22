import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';

/// 账单管理数据类

class BillBean {
  int id;
  double amount; //金额
  int time = -1; //时间,默认-1
  String timeFormat; //格式化后的时间
  String address; //位置
  String remark; //备注
  bool isPay; //是否是支出
  BillTypeBean billTypeBean; //类型信息
  BillPlanBean billPlanBean; //计划信息

  //构造函数
  BillBean();

  //从数据库中的map信息中构建类
  BillBean.fromDBMap(Map<String, dynamic> billMap, BillTypeBean billTypeBean,
      BillPlanBean billPlanBean) {
    this.id = billMap[DBConstant.BILL_ID];
    this.amount = billMap[DBConstant.BILL_AMOUNT];
    this.time = billMap[DBConstant.BILL_TIME];
    this.timeFormat =
        DateUtils.getTimeFormat(time, DateUtils.FORMAT_YYYY_MM_DD_HH_MM);
    this.address = billMap[DBConstant.BILL_ADDRESS];
    this.remark = billMap[DBConstant.BILL_REMARK];
    this.isPay = billMap[DBConstant.BILL_IS_PAY] == 1;
    this.billTypeBean = billTypeBean;
    this.billPlanBean = billPlanBean;
  }

  //将当前的数据转换为map信息
  Map<String, dynamic> toDBMap() {
    Map<String, dynamic> map = Map();
    //id设置为空，因为主键自增
    map[DBConstant.BILL_ID] = null;
    map[DBConstant.BILL_AMOUNT] = amount;
    map[DBConstant.BILL_TIME] = time;
    map[DBConstant.BILL_ADDRESS] = address;
    map[DBConstant.BILL_REMARK] = remark;
    map[DBConstant.BILL_IS_PAY] = isPay;
    map[DBConstant.BILL_TYPE_WITH_ID] = billTypeBean.id;
    map[DBConstant.BILL_PLAN_WITH_ID] = billPlanBean.id;

    return map;
  }
}
