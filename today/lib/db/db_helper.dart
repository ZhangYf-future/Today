import 'package:today/bean/bill/bill_bean.dart';
import 'package:today/bean/bill/bill_plan_bean.dart';
import 'package:today/bean/bill/bill_type_bean.dart';
import 'package:today/bean/comm/db_result_bean.dart';
import 'package:today/bean/weather/weather_city_db_bean.dart';
import 'package:today/constact/constact_string.dart';
import 'package:today/db/db_utils.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';
import 'package:today/utils/log_utils.dart';

///数据库中间类

class DBHelper {
  DBUtils _dbUtils = DBUtils.instance;

  ///账单计划表操作

  //读取账单计划类中的全部数据
  Future<List<BillPlanBean>> getAllBillPlan() async {
    List<Map<String, dynamic>> planListMap = await _dbUtils.getAllBillPlan();
    List<BillPlanBean> billPlanList = List.empty(growable: true);
    for (var item in planListMap) {
      billPlanList.add(BillPlanBean.fromMap(item));
    }
    return billPlanList;
  }

  //根据id获取一条账单计划信息
  Future<BillPlanBean?> getBillPlanWithId(String id) async {
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
  Future<BillPlanBean?> getCurrentMonthPlan() async {
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

  ///账单类型操作

  //向账单类型表中添加一条数据
  Future<int> insertABillType(BillTypeBean bean) async {
    return await _dbUtils.insertABillType(bean.parseInsertDBMap());
  }

  //从账单类型表中获取全部数据
  Future<List<BillTypeBean>> getAllBillType() async {
    List<Map<String, dynamic>> dbDataList = await _dbUtils.getAllBillType();
    List<BillTypeBean> result = List.empty(growable: true);
    for (Map<String, dynamic> map in dbDataList) {
      result.add(BillTypeBean.fromMap(map));
    }
    return result;
  }

  //根据账单类型id获取账单类型数据
  Future<BillTypeBean?> getBillTypeBeanWithId(String id) async {
    var result = await _dbUtils.getABillType(id);
    if (result != null) return BillTypeBean.fromMap(result);
    return null;
  }

  //获取权重最高的三条类型数据
  Future<List<BillTypeBean>> getBillTypeWithWeightTopThree() async {
    var dbResult = await _dbUtils.getThreeBillTypeWithWeight();
    List<BillTypeBean> list = List.empty(growable: true);
    if (dbResult != null && dbResult.isNotEmpty) {
      for (Map<String, dynamic> map in dbResult) {
        list.add(BillTypeBean.fromMap(map));
      }
    }
    return list;
  }

  //更新账单类型表中的一条数据
  Future<DBResultEntity> updateBillTypeBean(BillTypeBean bean) async {
    var map = bean.parseUpdateDBMap();
    var dbResult = await _dbUtils.updateABillType(map, bean.id.toString());
    var result = DBResultEntity();
    if (dbResult >= 0) {
      result.code = DBConstant.DB_RESULT_SUCCESS;
      result.msg = StringConstant.OPERATE_SUCCESS;
      result.result = dbResult;
    } else {
      result.code = DBConstant.DB_RESULT_FAILED;
      result.msg = StringConstant.OPERATE_FAILED;
      result.result = dbResult;
    }

    return result;
  }

  //根据账单类型id更新账单类型的权重数量
  Future updateBillTypeWeightWithId(int id, int weight) async {
    Map<String, dynamic> map = Map();
    map[DBConstant.BILL_TYPE_WEIGHT] = weight;
    await _dbUtils.updateBillTypeWeight(id, map);
  }

  ///账单表操作

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
    List<BillBean> result = List.empty(growable: true);
    //获取账单表中的全部数据
    var billDBValueList = await _dbUtils.getAllBill();

    for (Map<String, dynamic> item in billDBValueList) {
      //获取当前的typeId
      String typeId = item[DBConstant.BILL_TYPE_WITH_ID].toString();
      //根据typeid获取type信息
      BillTypeBean? typeBean = await getBillTypeBeanWithId(typeId);
      //获取当前的planid
      String planId = item[DBConstant.BILL_PLAN_WITH_ID].toString();
      //根据planid获取plan信息
      BillPlanBean? planBean = await getBillPlanWithId(planId);
      //创建账单信息
      BillBean billBean = BillBean.fromDBMap(item, typeBean, planBean);
      result.add(billBean);
    }
    return result;
  }

  //根据计划id获取账单表中和这个id相关的所有记录的金额
  Future<List<double>> getAllBillAmountWithPlanId(int planId) async {
    var result = await _dbUtils.getBillAmountWithPlanId(planId);
    var amountList = List<double>.empty(growable: true);
    for (Map<String, dynamic> map in result) {
      amountList.add(map[DBConstant.BILL_AMOUNT]);
    }
    return amountList;
  }

  //获取账单数据表中的最近10条数据
  Future<List<BillBean>> getBillLastTenRows() async {
    var list = await _dbUtils.getBillLastTen();
    var result = List<BillBean>.empty(growable: true);
    for (Map<String, dynamic> map in list) {
      //获取计划id
      var planId = map[DBConstant.BILL_PLAN_WITH_ID];
      var planMap = await _dbUtils.getBillPlanWithId(planId.toString());
      BillPlanBean planBean = BillPlanBean.fromMap(planMap!);
      //获取类型id
      var typeId = map[DBConstant.BILL_TYPE_WITH_ID];
      var typeMap = await _dbUtils.getABillType(typeId.toString());
      BillTypeBean typeBean = BillTypeBean.fromMap(typeMap!);
      result.add(BillBean.fromDBMap(map, typeBean, planBean));
    }

    return result;
  }

  //获取今日账单总数
  Future<double> getTodayBillCount() async {
    //获取今日数据库中的数据
    var list = await _dbUtils.getTodayBill();
    //计算总额
    var amount = 0.0;
    list.forEach((element) {
      element.forEach((key, value) {
        if (key == DBConstant.BILL_AMOUNT) {
          amount += value;
        }
      });
    });
    return amount;
  }

  ///向天气城市数据表中加入一条数据
  Future<DBResultEntity> insertWeatherCity(WeatherCityDBBean bean) async{
    final result = DBResultEntity();
    try{
      //查询城市的总数
      final List<Map<String,dynamic>> list = await _dbUtils.queryAllWeatherCityList();
      if(list.isNotEmpty && list.length >= 5){
        //城市数量超过5个,不能继续添加
        result.code = DBConstant.DB_RESULT_FAILED;
        result.msg = StringConstant.WEATHER_CITY_MORE_THAN_MAX;
        return result;
      }

      //查询是否已经有同样的数据了
      var checkRepeatData = await _dbUtils.queryWeatherCityExists(bean.hfId);
      if(checkRepeatData.isNotEmpty){
        //数据重复，不需要插入数据
        result.code = DBConstant.DB_RESULT_FAILED;
        result.result = bean;
        return result;
      }

      int id = await _dbUtils.insertWeatherCity(bean.toMap());
      Logs.ez("insertWeatherCity: success:$id");
      if(id == -1){
        result.code = DBConstant.DB_RESULT_FAILED;
      }
      result.result = id;
    }catch(e){
      Logs.ez("insertWeatherCity:$e");
        result.code = DBConstant.DB_RESULT_FAILED;
    }
    return result;
  }

  //请求全部城市信息列表
  Future<List<WeatherCityDBBean>> getAllWeatherCityList() async{

    final mapList = await _dbUtils.queryAllWeatherCityList();

    final cityList = <WeatherCityDBBean>[];

    mapList.forEach((element) { 
      cityList.add(WeatherCityDBBean.fromMap(element));
    });

    return cityList;
  }

  //根据id删除一个城市信息
  Future<DBResultEntity> deleteWeatherCityWithId(int id) async{
    final result = DBResultEntity();
    final deleteResult = await _dbUtils.deleteWeatherCityWithId(id);
    if(deleteResult != -1){
      result.code = DBConstant.DB_RESULT_SUCCESS;
    }else{
      result.code = DBConstant.DB_RESULT_FAILED;
      result.msg = StringConstant.DELETE_CITY_ERROR;
    }
    return result;
  }
}
