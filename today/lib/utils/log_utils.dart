import 'package:today/utils/date_utils.dart';

class Logs {
  static const String TAG_ZYF = "TAG_ZYF";

  static void e(String tag, String message) {
    print("${DateUtils.getCurrentTimeWithSeconds()}: \t $tag --> $message");
  }

  static void ez(String message) {
    e(TAG_ZYF, message);
  }
}
