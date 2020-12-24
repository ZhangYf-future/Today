import 'package:today/bean/bill/bill_bean.dart';
import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/bean/comm/db_result_bean.dart';
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

  //根据id获取一条账单计划信息
  Future<BillPlanBean> getBillPlanWithId(String id) async {
    var result = await _dbUtils.getBillPlanWithId(id);

    if (result != null) return BillPlanBean.fromMap(result);
    return null;
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

  //根据账单类型id获取账单类型数据
  Future<BillTypeBean> getBillTypeBeanWithId(String id) async {
    var result = await _dbUtils.getABillType(id);
    if (result != null) return BillTypeBean.fromMap(result);
    return null;
  }

  //向账单表中添加一条数据
  Future<DBResultEntity> insertABill(BillBean bean) async {
    DBResultEntity result = DBResultEntity();
    //默认操作出错
    result.code = DBConstant.DB_RESULT_FAILED;
    //判断金额信息是否正确
    if (bean.amount < 0) {
      result.msg = StringConstant.ERROR_BILL_AMOUNT;
      return result;
    }

    //判断时间信息是否正确
    if (bean.time < 0) {
      result.msg = StringConstant.ERROR_BILL_TIME;
      return result;
    }

    //判断计划信息是否设置
    if (bean.billPlanBean == null) {
      result.msg = StringConstant.ERROR_BILL_PLAN;
      return result;
    }

    //检查类型信息是否选择
    if (bean.billTypeBean == null) {
      result.msg = StringConstant.ERROR_BILL_TYPE;
      return result;
    }

    //设置信息正确
    result.code = DBConstant.DB_RESULT_SUCCESS;
    result.msg = StringConstant.OPERATE_SUCCESS;
    result.result = await _dbUtils.insertABill(bean.toDBMap());
    return result;
  }

  //获取全部账单数据
  Future<List<BillBean>> getAllBillBean() async {
    //保存结果的列表
    List<BillBean> result = List();
    //获取账单表中的全部数据
    var billDBValueList = await _dbUtils.getAllBill();

    for (Map<String, dynamic> item in billDBValueList) {
      //获取当前的typeId
      String typeId = item[DBConstant.BILL_TYPE_WITH_ID].toString();
      //根据typeid获取type信息
      BillTypeBean typeBean = await getBillTypeBeanWithId(typeId);
      //获取当前的planid
      String planId = item[DBConstant.BILL_PLAN_WITH_ID].toString();
      //根据planid获取plan信息
      BillPlanBean planBean = await getBillPlanWithId(planId);
      //创建账单信息
      BillBean billBean = BillBean.fromDBMap(item, typeBean, planBean);
      result.add(billBean);
    }
    return result;
  }

  //根据计划id获取账单表中和这个id相关的所有记录的金额
  Future<List<double>> getAllBillAmountWithPlanId(int planId) async {
    var result = await _dbUtils.getBillAmountWithPlanId(planId);
    var amountList = List<double>();
    for (Map<String, dynamic> map in result) {
      amountList.add(map[DBConstant.BILL_AMOUNT]);
    }
    return amountList;
  }

  //获取账单数据表中的最近10条数据
  Future<List<BillBean>> getBillLastTenRows() async {
    var list = await _dbUtils.getBillLastTen();
    var result = List<BillBean>();
    for (Map<String, dynamic> map in list) {
      //获取计划id
      var planId = map[DBConstant.BILL_PLAN_WITH_ID];
      var planMap = await _dbUtils.getBillPlanWithId(planId.toString());
      BillPlanBean planBean = BillPlanBean.fromMap(planMap);
      //获取类型id
      var typeId = map[DBConstant.BILL_TYPE_WITH_ID];
      var typeMap = await _dbUtils.getABillType(typeId.toString());
      BillTypeBean typeBean = BillTypeBean.fromMap(typeMap);
      result.add(BillBean.fromDBMap(map, typeBean, planBean));
    }

    return result;
  }
}
