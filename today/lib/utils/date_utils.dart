import 'package:intl/intl.dart';
import 'package:today/utils/log_utils.dart';

class DateUtils {
  //时间格式
  static const String FORMAT_YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
  static const String FORMAT_YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";
  static const String FORMAT_YYYY_MM_DD = "yyyy-MM-dd";
  static const String FORMAT_HH_MM_SS = "HH:mm:ss";
  static const String FORMAT_HH_MM = "HH:mm";
  static const String FORMAT_MM_DD = "MM-dd";

  //一天的时间长度
  static const int DURATION_ONE_DAY = 24 * 60 * 60 * 1000;

  //获取当前时间
  static String getCurrentTime() {
    DateTime current = DateTime.now();
    return DateFormat(FORMAT_YYYY_MM_DD_HH_MM_SS).format(current);
  }

  //获取当前时间，精确到分
  static String getCurrentTimeWithMinutes() {
    DateTime current = DateTime.now();
    return DateFormat(FORMAT_YYYY_MM_DD_HH_MM).format(current);
  }

  //获取当前时间，精确到秒
  static String getCurrentTimeWithSeconds() {
    DateTime current = DateTime.now();
    return DateFormat(FORMAT_HH_MM_SS).format(current);
  }

  //获取当前的年份
  static int getCurrentYear() {
    return DateTime.now().year;
  }

  //获取当前的月份
  static int getCurrentMonth() {
    return DateTime.now().month;
  }

  //将指定时间长度的时间转换为想要的格式
  static String getTimeFormat(int timeMillions, String format) {
    var time = DateTime.fromMillisecondsSinceEpoch(timeMillions);
    return DateFormat(format).format(time);
  }

  //获取今天结束的时间
  static int getTodayEnd() {
    //获取现在的时间
    DateTime now = DateTime.now();
    //获取今天结束的时间,23:59:59
    DateTime todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return todayEnd.millisecondsSinceEpoch;
  }

  //获取今天开始的时间戳 00:00:00
  static int getTodayStart() {
    //获取现在的时间
    DateTime now = DateTime.now();
    DateTime todayEnd = DateTime(now.year, now.month, now.day, 0, 0, 0);
    return todayEnd.millisecondsSinceEpoch;
  }

  //判断指定的时间距离现在是否大于20分钟
  static bool checkMoreThan20Minutes(int time) {
    final now = DateTime.now();
    final nowInt = now.millisecondsSinceEpoch;
    return nowInt - time > 20 * 60 * 1000;
  }

  //获取时间字符串的信息
  static String string2Date(String time) {
    final dateTime = DateTime.parse(time).toLocal();
    final dateFormat = DateFormat(FORMAT_HH_MM).format(dateTime);
    return dateFormat;
  }

  //将yyyy-MM-dd处理为MMdd
  static String formatDate(String fromDate, String toDateFormat) {
    final dateTime = DateTime.parse(fromDate).toLocal();
    final formatDate = DateFormat(toDateFormat).format(dateTime);
    return formatDate;
  }

  //判断是否超过后天
  static bool checkMoreThanTwoDay(String date) {
    //获取今天的时间
    final today = DateTime.now();
    final toDayStart =
        DateTime(today.year, today.month, today.day).millisecondsSinceEpoch;
    //两天的时间毫秒数
    final twoDays = 48 * 60 * 60 * 1000;
    //传递进来的时间
    final fromDate = DateTime.parse(date).toLocal().millisecondsSinceEpoch;
    return fromDate > twoDays + toDayStart;
  }

  //将返回今天，明天，后天或者以MM-dd的形式返回
  static String getDayDescription(String date) {
    final fromDate = DateTime.parse(date).toLocal().millisecondsSinceEpoch;
    if (fromDate >= getTodayStart() && fromDate <= getTodayEnd()) {
      return "今天";
    }

    //明天的开始时间和结束时间
    if (fromDate >= getTodayStart() + DURATION_ONE_DAY &&
        fromDate <= getTodayEnd() + DURATION_ONE_DAY) {
      return "明天";
    }

    //后天
    if (fromDate >= getTodayStart() + DURATION_ONE_DAY * 2 &&
        fromDate <= getTodayEnd() + DURATION_ONE_DAY * 2) {
      return "后天";
    }
    return formatDate(date, FORMAT_MM_DD);
  }
}
