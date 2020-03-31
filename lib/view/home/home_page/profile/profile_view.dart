import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/event_bus.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/view/account/login_view.dart';
import 'package:play/view/home/home_page/profile/profile_collection_page.dart';
import 'package:play/view/home/home_page/profile/profile_details_page.dart';
import 'package:play/view/opinion/change_theme_page.dart';
import 'package:play/widgets/common_web_page.dart';
import 'package:play/widgets/customdialog.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List menuTitles = [
    "我的积分",
    "我的收藏",
    "我的博客",
    "稍后阅读",
    "主题设置",
    "退出登录",
  ];
  final List menuIcons = [
    Icons.message,
    Icons.map,
    Icons.account_balance_wallet,
    Icons.question_answer,
    Icons.settings,
    Icons.backspace,
  ];
  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    //尝试显示用户信息
    _getUerInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息并显示
      _getUerInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      _getUerInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "我的",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.1,
      ),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHead();
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin) {
                switch (index) {
                  case 0:
                    if (isLogin) {
                      ToastUtils.showToast("我的积分");
                    } else {
                      _login();
                    }
                    break;
                  case 1:
                    if (isLogin) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileCollectionPage()));
                    } else {
                      _login();
                    }
                    break;
                  case 2:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommonWebPage(
                              title: "我的博客",
                              url: "https://blog.csdn.net/haojiagou",
                            )));
                    break;
                  case 3:
                    ToastUtils.showToast("稍后阅读");
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeThemePage()));
                    break;
                  case 5:
                    _logout();
                    break;
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
          );
        },
        itemCount: menuIcons.length + 1);
  }

  /*
   * 构建头像  "assets/images/ic_head.jpeg"
   */
  Container _buildHead() {
    return Container(
      color: ThemeUtils.currentColorTheme,
      padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setWidth(40),
          bottom: ScreenUtil.getInstance().setWidth(70)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xffffffff),
                    width: 1.0,
                  ),
                  image: DecorationImage(
                    image: userAvatar != null
                        ? NetworkImage(userAvatar)
                        : AssetImage("assets/images/ic_head.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                DataUtils.isLogin().then((isLogin) {
                  if (isLogin) {
                    //详情
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileDetailsPage()));
                  } else {
                    //执行登录
                    _login();
                  }
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              userName ??= "未登录",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(50)),
            ),
          ],
        ),
      ),
    );
  }

  void _getUerInfo() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getUserInfo().then((login) {
          if (mounted) {
            setState(() {
              print("出来吧大哥: ${login.nickname}");
              userAvatar = login.icon;
              userName = login.nickname;
            });
          }
        });
      } else {
        setState(() {
          userAvatar = null;
          userName = null;
        });
      }
    });
  }

  void _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginView()));
    ToastUtils.showToast("去登录");
  }

  void _logout() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return CustomDialog(
                confirmCallback: () async {
                  //退出登录
                  NetUtils.get(AppUrls.GET_LOGOUT).then((value) async {
                    print("home_page: " + value);
                    var data = json.decode(value);
                    if (data["errorCode"] == 0) {
                      ToastUtils.showToast("退出登录成功");
                      DataUtils.clearLoginInfo();
                      eventBus.fire(LogoutEvent());
                    }
                  });
                },
                confirmContent: "退出",
                content: '你确定要退出登录吗?',
                confirmColor: Colors.blue,
              );
            });
      }else{
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return CustomDialog(
                confirmCallback: () async {
                  _login();
                },
                confirmContent: "登录",
                content: '当前未登录，是否跳转登录?',
                confirmColor: Colors.blue,
              );
            });
      }
    });
  }
}
