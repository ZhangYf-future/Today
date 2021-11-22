import 'package:today/constact/constact_string.dart';
import 'package:today/utils/date_utils.dart';

class Logs {
  static const String TAG_ZYF = "TAG_ZYF";

  static void e(String tag, String message) {
    if (!bool.fromEnvironment(StringConstant.ENVIROMENT)) {
      print(
          "\n ${DateUtils.getCurrentTimeWithSeconds()}: \t $tag --> $message \n");
    }
  }

  static void ez(String message) {
    e(TAG_ZYF, message);
  }
}
