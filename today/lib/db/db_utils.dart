import 'package:sqflite/sqflite.dart';
import 'package:today/utils/constant.dart';

///数据库工具类
class DBUtils {
  static DBUtils _instance;
  static DBUtils get instance => _getInstance();
  static DBUtils _getInstance() {
    if (_instance == null) {
      _instance = DBUtils._single();
    }
    return _instance;
  }

  DBUtils._single() {
    //私有化构造函数
  }

  //工厂模式
  factory DBUtils() => _getInstance();

  //已经打开的数据库连接
  Database _database;
  Database get database {
    if (_database == null) throw Exception("请先执行openDB方法打开数据库");
    return _database;
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

    return _database;
  }

  //创建数据表
  void _createTable(Database database, int version) async {
    _createBillPlanTable(database);
    _createBillTypeTable(database);
    _createBillTable(database);
  }

  //更新数据库
  void _updateDB(Database database, int oldVersion, int newVersion) async {
    for (int i = oldVersion; i < newVersion; i++) {
      switch (i) {
        case DBConstant.DB_FIRST_VERSION:
          _updateDB2(database);
          break;
      }
    }
  }

  //更新数据库到第二个版本，添加账单类型表中的权重属性
  void _updateDB2(Database database) async {
    await database.execute(DBConstant.UPDATE_BILL_TYPE_TABLE_ADD_WEIGHT);
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
  Future<Map<String, dynamic>> getBillPlanWithId(String id) async {
    var values = List();
    values.add(id);
    var result = await database.query(DBConstant.BILL_PLAN_TABLE_NAME,
        where: "${DBConstant.BILL_PLAN_ID} = ?", whereArgs: values);

    if (result.length == 1) return result[0];

    return null;
  }

  //根据账单计划年度和月度获取当前计划信息
  Future<List<Map<String, dynamic>>> getBillPlanWithDate(
      int year, int month) async {
    var list = List();
    list.add(year);
    list.add(month);
    return await _database.query(DBConstant.BILL_PLAN_TABLE_NAME,
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
    List whereArgs = List();
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
    List whereArgs = List();
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
    List<dynamic> arguments = List();
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
  Future<Map<String, dynamic>> getABillType(String id) async {
    List whereArgs = List();
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
    var arguments = List();
    arguments.add(planId);
    //这里只需要获取金额数据
    var columnNameList = List<String>();
    columnNameList.add(DBConstant.BILL_AMOUNT);
    return await database.query(DBConstant.BILL_TABLE_NAME,
        columns: columnNameList,
        where: "${DBConstant.BILL_PLAN_WITH_ID} = ? ",
        whereArgs: arguments);
  }
}
