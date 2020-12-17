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
    return Column(
      children: [
        //顶部显示统计信息
        _StatisticsWidget(),
        //下面是一个ListView显示当月账单列表
      ],
    );
  }
}

//统计账单信息的部分
class _StatisticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.all(15.0),
      child: Container(
        child: Row(
          children: [
            Expanded(child: Text("本月消费")),
            Expanded(child: Text("本月计划消费")),
          ],
        ),
      ),
    );
  }
}
