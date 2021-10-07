import 'package:flutter/material.dart';

/// 保存常量的类

///路由页面名称常量
class RouteNameConstant {
  //首页
  static const String HOME_ROUTE = "homeRoute";
  //账单首页
  static const String BILL_HOME_ROUTE = "billHomeRoute";
  //添加账单计划页面
  static const String BILL_ADD_PLAN_ROUTE = "billAddPlanRoute";
  //添加账单页面
  static const String BILL_ADD_ROUTE = "billAddRoute";
  //账单类型列表页面
  static const String BILL_TYPE_LIST_ROUTE = "billTypeListRoute";
  //账单列表页面
  static const String BILL_LIST_ROUTE = "billListRoute";

  //天气首页
  static const String WEATHER_HOME_ROUTE = "weatherHomeRoute";
}

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

///字符串相关的常量
class StringConstant {
  //首页
  static const String MY_DAY = "我的一天";

  //我的账单
  static const String MY_BILL = "我的账单";
  static const String BILL = "账单";

  //添加账单计划
  static const String ADD_BILL_PLAN = "添加账单计划";
  //计划支出金额
  static const String PLAN_PAY_AMOUNT = "本月计划支出金额";
  //输入计划支出金额
  static const String INPUT_PLAN_PAY_AMOUNT = "请输入本月度计划支出金额";
  //年度
  static const String PLAN_YEAR = "计划年度";
  //月度
  static const String PLAN_MONTH = "计划月度";
  //输入计划需要注意的部分
  static const String BILL_PLAN_CARE_INFO = "请注意：月度计划创建之后不能修改和删除，后续操作都将建立在此计划上";

  //新的消费记录
  static const String NEW_BILL_RECORD = "新的消费记录";
  //没有消费计划提醒
  static const String NO_BILL_PLAN_REMIND = "创建当月计划";
  //添加数据
  static const String ADD_BILL_RECORD = "添加到账单";
  //全部账单
  static const String ALL_BILL = "全部账单";
  //暂无地址
  static const String NO_ADDRESS = "暂无地址";

  static const String ERROR_INPUT_RIGHT_PLAN_AMOUNT = "请输入正确的计划金额";
  static const String ERROR_YEAR = "错误的年份信息，请检查";
  static const String ERROR_MONTH = "错误的月份信息，请检查";
  static const String ERROR_INSERT = "添加数据出错，请稍候重试";
  static const String INSERT_DATA_SUCCESS = "数据添加成功";

  static const String CHECK_INFO = "请先检查以下信息是否正确";
  static const String TIME = "时间";
  static const String AMOUNT = "金额";
  static const String PLEASE_INPUT_PAY_AMOUNT = "请输入当前消费金额";
  static const String INPUT_ADDRESS = "请输入位置信息";
  static const String INPUT_REMARK = "请输入备注信息";
  static const String IS_PAY = "是否是支出";
  static const String I_THINK_IS_PAY = "我猜又是支出，如果不是，你可以点一下我";
  static const String IS_NOT_PAY = "哦~是收入，我喜欢这样！那么，就别点我了";
  static const String TYPE_INFO = "类型信息";
  static const String CHOOSE_TYPE_INFO = "请选择类型信息";
  static const String TYPE_INFO_REMIND = "账单类型信息表示钱用在了什么地方，点击这里选择或者添加";
  static const String PLAN_INFO = "计划信息";
  static const String PLAN_INFO_REMIND = "当前记录将被加入到这项消费计划中，此操作不可修改";
  static const String REMIND = "提示";
  static const String ADDRESS = "地址";
  static const String REMARK = "备注";
  static const String ADD_MONTH_PLAN = "加入月度计划";
  static const String NO_PLAN_REMIND = "请先点击底部按钮创建当月消费计划";
  static const String MONTH_PLAN = "月度计划";
  static const String CLICK_CHANGE = "点击切换";
  static const String IS = "是";
  static const String NO = "否";
  static const String PLEASE_CHOOSE_BILL_TYPE = "点击选择账单分类信息";
  static const String BILL_TYPE = "账单类型";
  static const String RECENTLY_BILL = "最近账单";
  static const String WATCH_ALL = "查看全部";
  static const String NO_BILL_RECORD = "暂无账单记录";
  static const String TIME_AND_PLAN = "时间和计划";
  static const String BILL_CATEGORY = "账单分类";
  static const String OTHER_INFO = "其它信息";
  static const String ADDRESS_AND_REMARK = "地址和备注";
  static const String PAY_TYPE = "支出类型";

  //账单类型列表页面
  static const String BILL_TYPE_LIST = "账单类型列表";
  static const String BILL_TYPE_LIST_NO_DATA = "暂无可选择的账单类型，请点击右下角的加号按钮添加新的账单类型";
  static const String ADD_BILL_TYPE = "新的账单类型";
  static const String MODIFY_BILL_TYPE = "修改账单类型";
  static const String TYPE_NAME = "类型名称";
  static const String PLEASE_INPUT_TYPE_NAME = "请输入类型名称";
  static const String REMARK_INFO = "备注信息";
  static const String PLEASE_INPUT_TYPE_REMARK = "请输入类型备注信息";

  //添加账单类型的说明文字
  static const String DESCRIPTION_ADD_TYPE = "账单类型表示钱用在了什么地方，比如生活消费等";

  //确认
  static const String CONFIRM = "确认";
  //编辑
  static const String EDIT = "编辑";
  //说明
  static const String DESCRIPTION = "说明";
  //确认添加
  static const String CONFIRM_ADD = "确认添加";
  //确认修改
  static const String CONFIRM_MODIFY = "确认修改";
  //操作成功
  static const String OPERATE_SUCCESS = "操作成功";
  //操作失败
  static const String OPERATE_FAILED = "操作失败";

  //账单时间信息出错
  static const String ERROR_BILL_TIME = "请检查账单时间信息是否正确";
  //金额是否正确
  static const String ERROR_BILL_AMOUNT = "请输入正确的账单金额";
  //计划信息出错
  static const String ERROR_BILL_PLAN = "请检查计划信息是否设置";
  //账单类型出错
  static const String ERROR_BILL_TYPE = "请检查账单类型是否选择";
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
  static const int DB_VERSION = DB_SECOND_VERSION;

  //数据库第一个版本
  static const int DB_FIRST_VERSION = 1;
  //数据库第二个版本，添加账单类型表的weight字段
  static const int DB_SECOND_VERSION = 2;

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
}

//首页Block数据类型部分常量
class HomeBlockConstant {
  //首页账单类型
  static const HOME_BLOCK_TYPE_BILL = "账单";
  static const HOME_BLOCK_NAME_BILL = "我的账单";
  static const HOME_BLOCK_TITLE_BILL = "记录账单信息 -->";

  //首页天气类型
  static const HOME_BLOCK_TYPE_WEATHER = "天气";
  static const HOME_BLOCK_NAME_WEATHER = "今日天气";
  static const HOME_BLOCK_TITLE_WEATHER = "查看想起天气 -->";
}
