import 'package:intl/intl.dart';
import 'package:today/utils/log_utils.dart';

class DateUtils {
  //时间格式
  static const String FORMAT_YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
  static const String FORMAT_YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";
  static const String FORMAT_YYYY_MM_DD = "yyyy-MM-dd";
  static const String FORMAT_HH_MM_SS = "HH:mm:ss";

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
    Logs.ez("today end time is ${todayEnd.millisecondsSinceEpoch}");
    return todayEnd.millisecondsSinceEpoch;
  }

  //获取今天开始的时间戳 00:00:00
  static int getTodayStart() {
    //获取现在的时间
    DateTime now = DateTime.now();
    DateTime todayEnd = DateTime(now.year, now.month, now.day, 0, 0, 0);
    Logs.ez("today start time is ${todayEnd.millisecondsSinceEpoch}");
    return todayEnd.millisecondsSinceEpoch;
  }

  //判断指定的时间距离现在是否大于20分钟
  static bool checkMoreThan20Minutes(int time){
    final now = DateTime.now();
    final nowInt = now.millisecondsSinceEpoch;
    return nowInt - time > 20 * 60 * 1000;
  }
}
