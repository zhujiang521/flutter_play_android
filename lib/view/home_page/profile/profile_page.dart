import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/coin_user_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/event_bus.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/view/account/login_page.dart';
import 'package:play/utils/change_theme_page.dart';
import 'package:play/widgets/common_web_page.dart';
import 'package:play/widgets/customdialog.dart';

import 'profile_about_page.dart';
import 'profile_coin_page.dart';
import 'profile_coin_ranking_page.dart';
import 'profile_collection_page.dart';
import 'profile_details_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List menuTitles = [
    "我的积分",
    "我的收藏",
    "我的博客",
    "主题设置",
    "关于作者",
    "退出登录",
  ];
  final List menuIcons = [
    Icons.message,
    Icons.map,
    Icons.account_balance_wallet,
    Icons.settings,
    Icons.info,
    Icons.backspace,
  ];
  String userAvatar;
  String userName;
  String nickname;

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
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.assessment,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileCoinRankingPage()));
              })
        ],
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileCoinPage()));
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
                              id: -1,
                            )));
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeThemePage()));
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileAboutPage()));
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
                width: ScreenUtil.getInstance().setWidth(200),
                height: ScreenUtil.getInstance().setWidth(200),
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
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            Text(
              userName ??= "未登录",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(50)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            Text(
              nickname ??= "未登录",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(40)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getUerInfo() async {
    var isLogin = await DataUtils.isLogin();
    if (isLogin) {
      var login = await DataUtils.getUserInfo();
      if (mounted) {
        userAvatar = login.icon == ""
            ? "http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg"
            : login.icon;
        userName = login.username;
        nickname = login.nickname;
      }
    } else {
      userAvatar = null;
      userName = null;
      nickname = null;
    }

    eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {});
    });

    setState(() {});
  }

  void _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
      } else {
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
