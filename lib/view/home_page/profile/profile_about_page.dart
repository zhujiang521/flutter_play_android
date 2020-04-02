import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_web_page.dart';
import 'package:play/widgets/custom_app_bar.dart';

import 'profile_exceptional_page.dart';

class ProfileAboutPage extends StatefulWidget {
  @override
  _ProfileAboutPageState createState() => _ProfileAboutPageState();
}

class _ProfileAboutPageState extends State<ProfileAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: "关于作者"),
      body: Container(
        color: ThemeUtils.currentColorTheme,
        child: Column(
          children: children(context),
        ),
      ),
    );
  }

  List<Widget> children(BuildContext context) {
    return <Widget>[
          _buildHead(),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(60),
          ),
          ListTile(
            leading: Icon(
              Icons.adb,
              color: Colors.red,
            ),
            title: Text(
              'Github',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "https://github.com/zhujiang521",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommonWebPage(
                        title: "我的Github",
                        url: "https://github.com/zhujiang521",
                        id: -1,
                      )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.red,
            ),
            title: Text(
              'CSDN博客',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "https://blog.csdn.net/haojiagou",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommonWebPage(
                        title: "我的博客",
                        url: "https://blog.csdn.net/haojiagou",
                        id: -1,
                      )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add,
              color: Colors.red,
            ),
            title: Text(
              '微信号',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "ZhuJiang0302",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              ClipboardData data = new ClipboardData(text: "ZhuJiang0302");
              Clipboard.setData(data);
              ToastUtils.showToast("复制成功，快去添加好友吧！");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text(
              '请我喝咖啡',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "对你有帮助的话就点击吧！",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileExceptionalPage()));
            },
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Image.asset(
            "assets/images/we_chart_mark.jpg",
            width: ScreenUtil.getInstance().setWidth(700),
            height: ScreenUtil.getInstance().setWidth(700),
          )
        ];
  }

  Container _buildHead() {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setWidth(40),
          bottom: ScreenUtil.getInstance().setWidth(70)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(200),
              height: ScreenUtil.getInstance().setWidth(200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xffffffff),
                  width: 1.0,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(40),
            ),
            Text(
              "ZhuJiang",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(50)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(40),
            ),
            Text(
              "只要开始，永远不晚。只要努力，就有可能",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(40)),
            ),
          ],
        ),
      ),
    );
  }
}
