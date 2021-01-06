///数字相关的工具类

class NumberUtils {
  //保留double类型的数据小数点后两位
  static double lastTwoNumber(double source) {
    return source.ceilToDouble();
  }
}
