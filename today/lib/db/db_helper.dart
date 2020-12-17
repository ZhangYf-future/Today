import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/db/db_utils.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';

///数据库中间类

class DBHelper {
  DBUtils _dbUtils = DBUtils.instance;

  //读取账单计划类中的全部数据
  Future<List<BillPlanBean>> getAllBillPlan() async {
    List<Map<String, dynamic>> planListMap = await _dbUtils.getAllBillPlan();
    List<BillPlanBean> billPlanList = List();
    for (var item in planListMap) {
      billPlanList.add(BillPlanBean.fromMap(item));
    }
    return billPlanList;
  }

  //判断当前月份是否存在计划
  Future<bool> checkCurrentMonthPlan() async {
    var list = await getAllBillPlan();
    if (list == null || list.isEmpty) return false;
    //获取当前年度和月度
    var currentYear = DateUtils.getCurrentYear();
    var currentMonth = DateUtils.getCurrentMonth();
    print("当前年份:$currentYear,当前月份:$currentMonth");
    for (var planBean in list) {
      if (planBean.checkDateEquals(currentYear, currentMonth)) return true;
    }

    return false;
  }

  //获取当前月份的计划信息
  Future<BillPlanBean> getCurrentMonthPlan() async {
    int currentYear = DateUtils.getCurrentYear();
    int currentMonth = DateUtils.getCurrentMonth();
    var result = await _dbUtils.getBillPlanWithDate(currentYear, currentMonth);
    if (result == null || result.isEmpty) return null;
    if (result.length != 1) throw Exception("获取到计划数量不为1，请检查数据");
    return BillPlanBean.fromMap(result[0]);
  }

  //向账单计划表中添加一条记录
  Future<String> insertBillPlan(BillPlanBean bean) async {
    if (bean.planAmount == null || bean.planAmount <= 0) {
      return StringConstant.ERROR_INPUT_RIGHT_PLAN_AMOUNT;
    }

    //获取当前年份
    var currentYear = DateUtils.getCurrentYear();
    if (bean.planYear == null || bean.planYear != currentYear) {
      return StringConstant.ERROR_YEAR;
    }

    //获取当前月份
    var currentMonth = DateUtils.getCurrentMonth();
    if (bean.planMonth == null || bean.planMonth != currentMonth) {
      return StringConstant.ERROR_MONTH;
    }

    //设置时间
    bean.createTime = DateUtils.getCurrentTime();

    //添加数据
    int result = await _dbUtils.insertToAllBillPlan(bean.insertDB());
    if (result < 0) {
      return StringConstant.ERROR_INSERT;
    }

    return StringConstant.INSERT_DATA_SUCCESS;
  }

  //向账单类型表中添加一条数据
  Future<int> insertABillType(BillTypeBean bean) async {
    return await _dbUtils.insertABillType(bean.parseDBMap());
  }

  //从账单类型表中获取全部数据
  Future<List<BillTypeBean>> getAllBillType() async {
    List<Map<String, dynamic>> dbDataList = await _dbUtils.getAllBillType();
    List<BillTypeBean> result = List();
    for (Map<String, dynamic> map in dbDataList) {
      result.add(BillTypeBean.fromMap(map));
    }
    return result;
  }
}
