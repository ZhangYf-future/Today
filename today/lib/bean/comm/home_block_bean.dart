import 'package:flutter/material.dart';

/**
 * 首页Block数据块类型的数据类
 */
class HomeBlockBean {
  //类型
  final String type;
  //名称
  final String name;
  //标题
  final String title;
  //icon
  final Icon icon;

  HomeBlockBean(this.type, this.name, this.title, this.icon);

}
