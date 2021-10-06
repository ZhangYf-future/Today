import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///首页账单信息的Block
class HomeBillBlockWidget extends StatefulWidget {
  final HomeBlockBean homeBlockBean;

  const HomeBillBlockWidget(this.homeBlockBean, {Key key}) : super(key: key);

  @override
  _BillBlockState createState() => _BillBlockState(homeBlockBean);
}

class _BillBlockState extends State<HomeBillBlockWidget> {
  final HomeBlockBean _homeBlockBean;

  _BillBlockState(this._homeBlockBean);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 10,
        color: ColorConstant.COLOR_RED,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  this._homeBlockBean.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                      fontSize: 20.0),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 50.0,
                      right: 20.0,
                    ),
                    child: Text(
                      this._homeBlockBean.title,
                      style: TextStyle(
                          color: ColorConstant.COLOR_F2F2F2, fontSize: 12.0),
                    ),
                  )),
            ],
          ),
        ),
      ),
      //点击操作
      onTap: () => {
        //跳转到账单首页
        JumpUtils.toNextRouteWithName(
            context, RouteNameConstant.BILL_HOME_ROUTE)
      },
    );
  }
}
