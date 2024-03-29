import 'package:flutter/material.dart';
import 'package:today/bean/comm/home_block_bean.dart';
import 'package:today/constact/constant_string.dart' as cs;
import 'package:today/constact/constant_route.dart';
import 'package:today/utils/constant.dart';
import 'package:today/utils/jump_route_utils.dart';

///首页账单信息的Block
class HomeBillBlockWidget extends StatelessWidget {
  final HomeBlockBean _homeBlockBean;

  final double? _amount;

  const HomeBillBlockWidget(this._homeBlockBean, this._amount, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 64, 90, 100),
        child: Container(
            child: (_amount == null || _amount! <= 0.0)
                ? createNoAmountWidget()
                : createAmountWidget()),
      ),
      //点击操作
      onTap: () => {
        //跳转到账单首页
        JumpUtils.toNextRouteWithName(
            context, RouteNameConstant.BILL_HOME_ROUTE)
      },
    );
  }

  //创建没有金额时显示的信息
  Widget createNoAmountWidget() => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //显示我的账单标题
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text(
              this._homeBlockBean.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR,
                  fontSize: 20.0),
            ),
          ),
          //显示记录账单信息的文字
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(left: 50.0, right: 20.0, bottom: 20.0),
                child: Text(
                  this._homeBlockBean.title,
                  style: TextStyle(
                      color: ColorConstant.COLOR_F2F2F2, fontSize: 12.0),
                ),
              )),
        ],
      );

  //创建有金额时显示的信息
  Widget createAmountWidget() => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text.rich(
                TextSpan(
                  text: "${cs.StringConstant.TODAY_USE}: ",
                  style: TextStyle(
                      fontSize: 18, color: ColorConstant.COLOR_F2F2F2),
                  children: [
                    TextSpan(
                      text: "${_amount!.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.COLOR_DEFAULT_TEXT_COLOR),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 10.0,
                ),
                child: Text(
                  cs.StringConstant.WATCH_MORE,
                  style: TextStyle(
                    color: ColorConstant.COLOR_F2F2F2,
                  ),
                ),
              ),
            ),
          ]);
}
