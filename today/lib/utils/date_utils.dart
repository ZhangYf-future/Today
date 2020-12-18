import 'package:intl/intl.dart';

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
}
