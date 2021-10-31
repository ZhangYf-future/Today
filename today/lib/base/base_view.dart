import 'package:flutter/cupertino.dart';
import 'package:today/base/base_presenter.dart';
import 'package:today/main.dart';
import 'package:today/utils/string_utils.dart';

abstract class BaseView {
  //更新当前页面
  void updatePage();

  //退出当前页面
  void exit() {}

  //显示消息
  void showMessage(String message);
}

abstract class BaseState<W extends StatefulWidget> extends State<W>
    implements BaseView {
  //更新当前页面
  @override
  void updatePage() {
    if (mounted) {
      setState(() {
      });
    }
  }

  //退出当前页面
  @override
  void exit() {
    Navigator.pop(context);
  }

  //显示消息
  @override
  void showMessage(String message) {
    if (!StringUtils.isEmpty(message)) {
      showInfo(message);
    }
  }
}
