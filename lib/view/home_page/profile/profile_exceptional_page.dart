import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:play/widgets/custom_app_bar.dart';

class ProfileExceptionalPage extends StatefulWidget {
  @override
  _ProfileExceptionalPageState createState() => _ProfileExceptionalPageState();
}

class _ProfileExceptionalPageState extends State<ProfileExceptionalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: "请我喝咖啡"),
      body: Container(
        width: ScreenUtil.getInstance().width,
        color: ThemeUtils.currentColorTheme,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Image.asset(
              "assets/images/alipay.jpg",
              height: ScreenUtil.getInstance().setWidth(850),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(50),
            ),
            Image.asset(
              "assets/images/we_chart_pay.jpg",
              height: ScreenUtil.getInstance().setWidth(770),
            )
          ],
        ),
      ),
    );
  }
}
