import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///账单首页

class BillHomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_THEME_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringConstant.MY_BILL,
          style: TextStyle(
              color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR, fontSize: 18.0),
        ),
      ),
      body: _ContentWidget(),
      floatingActionButton: FlatButton(
        child: Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 50.0,
        ),
        onPressed: () => {
          //跳转到添加账单的页面
          JumpUtils.toNextRouteWithNameGetResult(
              context, RouteNameConstant.BILL_ADD_ROUTE)
        },
      ),
    );
  }
}

//内容部分
class _ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContentState();
  }
}

class _ContentState extends State<_ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Text("账单列表"),
    );
  }
}
