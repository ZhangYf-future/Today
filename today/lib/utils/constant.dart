import 'package:flutter/material.dart';

/// 保存常量的类


///颜色相关常量
class ColorConstant {
  //主题背景颜色
  static const Color COLOR_THEME_BACKGROUND = Colors.greenAccent;
  //默认的文本颜色为白色
  static const Color COLOR_DEFAULT_TEXT_COLOR = Colors.white;
  //红色
  static const Color COLOR_RED = Colors.redAccent;
  //灰色
  static const Color COLOR_424242 = Color.fromARGB(255, 66, 66, 66);
  static const Color Color_DCDCDC = Color.fromARGB(255, 220, 220, 220);
  static const Color COLOR_8B8B7A = Color.fromARGB(255, 139, 139, 122);

  static const Color COLOR_F2F2F2 = Color.fromARGB(255, 242, 242, 242);
}

///数据库部分常量
class DBConstant {
  //默认的数据库操作结果
  //数据库操作成功
  static const int DB_RESULT_SUCCESS = 0;
  //数据库操作失败
  static const int DB_RESULT_FAILED = -1;

  //数据库名称
  static const String DB_NAME = "toDayManage.db";
  //数据库版本号
  static const int DB_VERSION = DB_FOUR_VERSION;

  //数据库第一个版本
  static const int DB_FIRST_VERSION = 1;
  //数据库第二个版本，添加账单类型表的weight字段
  static const int DB_SECOND_VERSION = 2;
  //数据库第三个版本,不会执行任何操作
  static const int DB_THREE_VERSION = 3;
  //数据库第四个版本，添加天气城市数据表,第三个版本的数据表有问题
  static const int DB_FOUR_VERSION = 4;


  //账单管理部分
  //账单表名称
  static const String BILL_TABLE_NAME = "bill";
  //账单表字段
  //id
  static const String BILL_ID = "id";
  //金额
  static const String BILL_AMOUNT = "amount";
  //时间
  static const String BILL_TIME = "time";
  //地点
  static const String BILL_ADDRESS = "address";
  //备注
  static const String BILL_REMARK = "remark";
  //支出或者收入
  static const String BILL_IS_PAY = "isPay";
  //类型表中的id
  static const String BILL_TYPE_WITH_ID = "typeId";
  //计划表中的id
  static const String BILL_PLAN_WITH_ID = "planId";

  //账单类型表部分
  //账单类型表名称
  static const String BILL_TYPE_TABLE_NAME = "billType";
  //账单类型表字段
  //id
  static const String BILL_TYPE_ID = "id";
  //名称
  static const String BILL_TYPE_NAME = "name";
  //备注
  static const String BILL_TYPE_REMARK = "remark";
  //创建时间
  static const String BILL_TYPE_CREATE_TIME = "createTime";
  //权重信息，用户每选择一次则会加一
  static const String BILL_TYPE_WEIGHT = "weight";

  //账单计划表部分
  //账单计划表名称
  static const String BILL_PLAN_TABLE_NAME = "billPlan";
  //id
  static const String BILL_PLAN_ID = "id";
  //计划支出金额
  static const String BILL_PLAN_AMOUNT = "planAmount";
  //计划年度
  static const String BILL_PLAN_YEAR = "year";
  //计划月度
  static const String BILL_PLAN_MONTH = "month";
  //创建时间
  static const String BILL_PLAN_CREATE_TIME = "createTime";


  //创建账单数据表
  static const String CREATE_BILL_TABLE = """
    CREATE TABLE IF NOT EXISTS $BILL_TABLE_NAME(
      $BILL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $BILL_AMOUNT REAL NOT NULL,
      $BILL_TIME NUMERIC NOT NULL,
      $BILL_ADDRESS TEXT,
      $BILL_REMARK TEXT,
      $BILL_IS_PAY NUMERIC NOT NULL,
      $BILL_TYPE_WITH_ID INTEGER NOT NULL,
      $BILL_PLAN_WITH_ID INTEGER NOT NULL
    );
  """;

  //创建账单类型数据表
  static const String CREATE_BILL_TYPE_TABLE =
      """CREATE TABLE IF NOT EXISTS $BILL_TYPE_TABLE_NAME(
      $BILL_TYPE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $BILL_TYPE_NAME TEXT NOT NULL,
      $BILL_TYPE_REMARK TEXT,
      $BILL_TYPE_CREATE_TIME TEXT NOT NULL,
      $BILL_TYPE_WEIGHT INTEGER
  );""";

  //创建账单计划表
  static const String CREATE_BILL_PLAN_TABLE = """
      CREATE TABLE IF NOT EXISTS $BILL_PLAN_TABLE_NAME(
        $BILL_PLAN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $BILL_PLAN_AMOUNT REAL NOT NULL,
        $BILL_PLAN_YEAR INTEGER NOT NULL,
        $BILL_PLAN_MONTH INTEGER NOT NULL,
        $BILL_PLAN_CREATE_TIME TEXT NOT NULL
      );
    """;


  //获取账单表中的最后10条数据
  static const String GET_BILL_LAST_TEN_ROW = """
    SELECT * FROM $BILL_TABLE_NAME ORDER BY $BILL_TIME DESC LIMIT 10;
  """;

  //获取账单类型数据表中权重最大的三条数据
  static const String GET_BILL_TYPE_WITH_WEIGHT_THREE_ROW = """
    SELECT * FROM $BILL_TYPE_TABLE_NAME ORDER BY $BILL_TYPE_WEIGHT DESC LIMIT 3;
  """;

  //如果用户是更新数据库，则执行此方法更新数据库
  static const String UPDATE_BILL_TYPE_TABLE_ADD_WEIGHT = """
    ALTER TABLE $BILL_TYPE_TABLE_NAME ADD COLUMN $BILL_TYPE_WEIGHT INTEGER;
  """;


  ///保存用户选择的城市信息的数据表,获取天气信息的时候需要保存用户选择的城市信息
  static const String TABLE_NAME_WEATHER_CITY = "WeatherCityTable";
  static const String TABLE_WEATHER_CITY_ID = "id";
  static const String TABLE_WEATHER_CITY_HF_ID = "hfId";//保存请求到的和风天气API中的id信息，后面通过这个id去请求天气信息
  static const String TABLE_WEATHER_CITY_ADDRESS = "address";//保存具体的地址信息，中国-陕西省-西安市-长安区
  static const String TABLE_WEATHER_CITY_NAME = "city";//保存城市名，如西安市
  static const String TABLE_WEATHER_CITY_REGION = "region";//保存区或者县的名称，如长安区

  ///创建天气城市表
  static const String CREATE_TABLE_WEATHER_CITY = """
    CREATE TABLE IF NOT EXISTS $TABLE_NAME_WEATHER_CITY(
      $TABLE_WEATHER_CITY_ID INTEGER PRIMARY KEY,
      $TABLE_WEATHER_CITY_HF_ID TEXT NOT NULL,
      $TABLE_WEATHER_CITY_NAME TEXT NOT NULL,
      $TABLE_WEATHER_CITY_REGION TEXT NOT NULL,
      $TABLE_WEATHER_CITY_ADDRESS TEXT NOT NULL,
      unique($TABLE_WEATHER_CITY_HF_ID)
    );
  """;
}

//首页Block数据类型部分常量
class HomeBlockConstant {
  //首页账单类型
  static const HOME_BLOCK_TYPE_BILL = "账单";
  static const HOME_BLOCK_NAME_BILL = "我的账单";
  

  //首页天气类型
  static const HOME_BLOCK_TYPE_WEATHER = "天气";
  static const HOME_BLOCK_NAME_WEATHER = "今日天气";
  static const HOME_BLOCK_TITLE_WEATHER = "查看详细天气 -->";
}


