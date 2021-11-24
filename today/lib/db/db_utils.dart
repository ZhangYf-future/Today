import 'package:sqflite/sqflite.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/date_utils.dart';
import 'package:today/utils/log_utils.dart';

///数据库工具类
class DBUtils {
  //单例模式
  static DBUtils? _instance;
  static DBUtils get instance => _getInstance();
  static DBUtils _getInstance() {
    if (_instance == null) {
      _instance = DBUtils._single();
    }
    return _instance!;
  }

  DBUtils._single() {
    //私有化构造函数
  }

  //工厂构造函数
  factory DBUtils() => _getInstance();

  //已经打开的数据库连接
  Database? _database;
  Database get database {
    if (_database == null) throw Exception("请先执行openDB方法打开数据库");
    return _database!;
  }

  //打开一个数据库,如果数据库不存在，则会自动创建一个数据库,同时在数据库创建完成后会创建相应的数据表
  //注意：只有设置了数据库名称和数据库版本号才能创建数据表
  Future<Database> openDB() async {
    if (_database != null) throw Exception("数据库已经打开，请直接通过databse方法获取");
    String path = (await getDatabasesPath()) + DBConstant.DB_NAME;
    _database = await openDatabase(path,
        version: DBConstant.DB_VERSION,
        onCreate: _createTable,
        onUpgrade: _updateDB);

    return _database!;
  }

  //创建数据表
  void _createTable(Database database, int version) async {
    print("will create tables");
    _createBillPlanTable(database);
    _createBillTypeTable(database);
    _createBillTable(database);
    //注意本来这里是需要添加这行代码的，但是由于之前的错误操作，导致weight字段已经被添加到创建表的时候，所以这里如果代码不回滚的话就无需再添加这行代码了
    //_updateDB2(database);
    _updateDB4(database);
  }

  //更新数据库
  void _updateDB(Database database, int oldVersion, int newVersion) async {
    Logs.ez("_updateDB old version is $oldVersion,new version is $newVersion");
    for (int i = oldVersion; i < newVersion; i++) {
      switch (i) {
        case DBConstant.DB_FIRST_VERSION:
          //当前处于第一个版本,
          //注意本来这里是需要添加这行代码的，但是由于之前的错误操作，导致weight字段已经被添加到创建表的时候，所以这里如果代码不回滚的话就无需再添加这行代码了
          //_updateDB2(database);
          break;
        case DBConstant.DB_THREE_VERSION:
          //当前处于第三个版本，需要创建天气城市表
          _updateDB4(database);
          break;
      }
    }
  }

  //更新数据库到第二个版本，添加账单类型表中的权重属性
  void _updateDB2(Database database) async {
    await database.execute(DBConstant.UPDATE_BILL_TYPE_TABLE_ADD_WEIGHT);
  }

  //更新数据库到第四个版本，添加天气城市数据表
  void _updateDB4(Database database) async {
    await database.execute(DBConstant.CREATE_TABLE_WEATHER_CITY);
  }

  //创建账单计划数据表
  void _createBillPlanTable(Database database) async {
    await database.execute(DBConstant.CREATE_BILL_PLAN_TABLE);
  }

  //创建账单类型数据表
  void _createBillTypeTable(Database database) async {
    await database.execute(DBConstant.CREATE_BILL_TYPE_TABLE);
  }

  //创建账单数据表
  void _createBillTable(Database database) async {
    await database.execute(DBConstant.CREATE_BILL_TABLE);
  }

  //获取账单计划表中的全部数据
  Future<List<Map<String, dynamic>>> getAllBillPlan() async {
    return await database.query(DBConstant.BILL_PLAN_TABLE_NAME);
  }

  //根据账单计划id获取账单计划表中的一条数据
  Future<Map<String, dynamic>?> getBillPlanWithId(String id) async {
    var values = List.empty(growable: true);
    values.add(id);
    var result = await database.query(DBConstant.BILL_PLAN_TABLE_NAME,
        where: "${DBConstant.BILL_PLAN_ID} = ?", whereArgs: values);

    if (result.length == 1) return result[0];

    return null;
  }

  //根据账单计划年度和月度获取当前计划信息
  Future<List<Map<String, dynamic>>> getBillPlanWithDate(
      int year, int month) async {
    var list = List.empty(growable: true);
    list.add(year);
    list.add(month);
    return await _database!.query(DBConstant.BILL_PLAN_TABLE_NAME,
        where:
            "${DBConstant.BILL_PLAN_YEAR} = ? AND ${DBConstant.BILL_PLAN_MONTH} = ?",
        whereArgs: list);
  }

  //向账单计划表中添加一条数据
  Future<int> insertToAllBillPlan(Map<String, dynamic> data) async {
    return await database.insert(DBConstant.BILL_PLAN_TABLE_NAME, data);
  }

  ///账单类型表操作
  //从账单类型数据库中获取全部数据
  Future<List<Map<String, dynamic>>> getAllBillType() async {
    return await database.query(DBConstant.BILL_TYPE_TABLE_NAME);
  }

  //向账单类型表中添加一条数据
  Future<int> insertABillType(Map<String, dynamic> map) async {
    return await database.insert(DBConstant.BILL_TYPE_TABLE_NAME, map);
  }

  //根据账单类型id修改账单类型表中的数据
  Future<int> updateABillType(Map<String, dynamic> map, String id) async {
    List whereArgs = List.empty(growable: true);
    whereArgs.add(id);
    return await database.update(
      DBConstant.BILL_TYPE_TABLE_NAME,
      map,
      where: "${DBConstant.BILL_TYPE_ID} = ?",
      whereArgs: whereArgs,
    );
  }

  //根据id删除张单类型表中的一条数据
  Future<int> deleteABillType(String id) async {
    List whereArgs = List.empty(growable: true);
    whereArgs.add(id);
    return await database.delete(DBConstant.BILL_TYPE_TABLE_NAME,
        where: "${DBConstant.BILL_TYPE_ID} = ?", whereArgs: whereArgs);
  }

  //从账单类型表中根据权重获取前三条数据
  Future<List<Map<String, dynamic>>> getThreeBillTypeWithWeight() async {
    List<Map<String, dynamic>> result =
        await database.rawQuery(DBConstant.GET_BILL_TYPE_WITH_WEIGHT_THREE_ROW);
    return result;
  }

  //更新选中的账单类型权重信息
  updateBillTypeWeight(int id, Map<String, dynamic> values) async {
    List<dynamic> arguments = List.empty(growable: true);
    arguments.add(id);
    database.update(
      DBConstant.BILL_TYPE_TABLE_NAME,
      values,
      where: "${DBConstant.BILL_TYPE_ID} = ?",
      whereArgs: arguments,
    );
  }

  ///账单表操作
  //根据id获取账单类型表中的一条数据
  Future<Map<String, dynamic>?> getABillType(String id) async {
    List whereArgs = List.empty(growable: true);
    whereArgs.add(id);
    var result = await database.query(DBConstant.BILL_TYPE_TABLE_NAME,
        where: "${DBConstant.BILL_TYPE_ID} = ?", whereArgs: whereArgs);
    if (result.length == 1) return result[0];
    return null;
  }

  //向账单表中添加一条数据
  Future<int> insertABill(Map<String, dynamic> map) async {
    return await database.insert(DBConstant.BILL_TABLE_NAME, map);
  }

  //获取账单表中的全部数据
  Future<List<Map<String, dynamic>>> getAllBill() async {
    return await database.query(DBConstant.BILL_TABLE_NAME);
  }

  //获取账单表中最后插入的10条数据
  Future<List<Map<String, dynamic>>> getBillLastTen() async {
    return await database.rawQuery(DBConstant.GET_BILL_LAST_TEN_ROW);
  }

  //根据计划id获取和当前计划id相关的金额
  Future<List<Map<String, dynamic>>> getBillAmountWithPlanId(int planId) async {
    var arguments = List.empty(growable: true);
    arguments.add(planId);
    //这里只需要获取金额数据
    var columnNameList = List<String>.empty(growable: true);
    columnNameList.add(DBConstant.BILL_AMOUNT);
    return await database.query(DBConstant.BILL_TABLE_NAME,
        columns: columnNameList,
        where: "${DBConstant.BILL_PLAN_WITH_ID} = ? ",
        whereArgs: arguments);
  }

  //获取账单表中今天的数据
  Future<List<Map<String, dynamic>>> getTodayBill() async {
    var todayStart = DateUtils.getTodayStart();
    var todayEnd = DateUtils.getTodayEnd();
    var where =
        "${DBConstant.BILL_TIME} >= $todayStart AND ${DBConstant.BILL_TIME} <= $todayEnd";
    //这里只需要获取金额数据
    var columnNameList = List<String>.empty(growable: true);
    columnNameList.add(DBConstant.BILL_AMOUNT);
    return await database.query(
      DBConstant.BILL_TABLE_NAME,
      columns: columnNameList,
      where: where,
    );
  }

  ///向天气城市表中添加一条数据
  Future<int> insertWeatherCity(Map<String, dynamic> map) async {
    return await database.insert(DBConstant.TABLE_NAME_WEATHER_CITY, map);
  }

  //根据和风天气id从数据库中查询是否已经存在当前数据
  Future<List<Map<String, dynamic>>> queryWeatherCityExists(String hfId) async {
    //查询条件
    var whereArgs = <String>[];
    whereArgs.add(hfId);
    return await database.query(DBConstant.TABLE_NAME_WEATHER_CITY,
        where: "${DBConstant.TABLE_WEATHER_CITY_HF_ID} = ?",
        whereArgs: whereArgs);
  }

  //从数据库中查询出全部的城市信息
  Future<List<Map<String, dynamic>>> queryAllWeatherCityList() async {
    return await database.query(DBConstant.TABLE_NAME_WEATHER_CITY);
  }

  //根据id删除数据库中的一条数据
  Future<int> deleteWeatherCityWithId(int id) async {
    return database.delete(DBConstant.TABLE_NAME_WEATHER_CITY,
        where: "${DBConstant.TABLE_WEATHER_CITY_ID} = ? ",
        whereArgs: [id.toString()]);
  }
}
