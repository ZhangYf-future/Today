///文本相关的工具类

class StringUtils {
  //判断一个文本是否为空
  static bool isEmpty(String text) {
    return text == null || text.length == 0;
  }

  //判断一个文本是否为非空
  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }
}
