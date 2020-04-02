import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/login_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/event_bus.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameCtrl = TextEditingController(text: '');
  final passwordCtrl = TextEditingController(text: '');
  final rePasswordCtrl = TextEditingController(text: '');

  // 是否隐藏输入的文本
  bool obscurePassText = true;

  // 是否隐藏输入的文本
  bool obscureRePassText = true;

  // 是否正在注册
  bool isOnLogin = false;

  @override
  Widget build(BuildContext context) {
    var loginBtn = Builder(builder: (ctx) {
      return CommonButton(
          text: "注册",
          onTap: () {
            if (isOnLogin) return;
            // 拿到用户输入的账号密码
            String username = usernameCtrl.text.trim();
            String password = passwordCtrl.text.trim();
            String rePassword = rePasswordCtrl.text.trim();
            if (username.isEmpty || password.isEmpty || rePassword.isEmpty) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text("账号和密码不能为空！"),
              ));
              return;
            }
            if (password.length < 6) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text("密码长度必须大于6位！"),
              ));
              return;
            }
            if (password != rePassword) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text("两次密码输入不一致！"),
              ));
              return;
            }
            // 关闭键盘
            FocusScope.of(context).requestFocus(FocusNode());
            autoRegister(username, password, rePassword);
          });
    });

    var loadingView;
    if (isOnLogin) {
      loadingView = Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[CupertinoActivityIndicator(), Text("注册中，请稍等...")],
        ),
      ));
    } else {
      loadingView = Center();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("注册", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Center(child: Text("请输入注册的账号密码")),
              Container(height: ScreenUtil.getInstance().setWidth(50)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("用户名："),
                  Expanded(
                      child: TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                        hintText: "请输入账户",
                        hintStyle: TextStyle(color: const Color(0xFF808080)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0))),
                        contentPadding: const EdgeInsets.all(10.0)),
                  )),
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(100),
                      height: ScreenUtil.getInstance().setWidth(100),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.clear,
                        size: ScreenUtil.getInstance().setWidth(50),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        usernameCtrl.text = "";
                      });
                    },
                  )
                ],
              ),
              Container(height: ScreenUtil.getInstance().setHeight(20)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("密　码："),
                  Expanded(
                      child: TextField(
                    controller: passwordCtrl,
                    obscureText: obscurePassText,
                    decoration: InputDecoration(
                        hintText: "请输入密码",
                        hintStyle: TextStyle(color: const Color(0xFF808080)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0))),
                        contentPadding: const EdgeInsets.all(10.0)),
                  )),
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(100),
                      height: ScreenUtil.getInstance().setWidth(100),
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/ic_eye.png",
                          width: ScreenUtil.getInstance().setWidth(50),
                          height: ScreenUtil.getInstance().setWidth(50)),
                    ),
                    onTap: () {
                      setState(() {
                        obscurePassText = !obscurePassText;
                      });
                    },
                  )
                ],
              ),
              Container(height: ScreenUtil.getInstance().setHeight(20)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("密　码："),
                  Expanded(
                      child: TextField(
                    controller: rePasswordCtrl,
                    obscureText: obscureRePassText,
                    decoration: InputDecoration(
                        hintText: "请再次输入输入密码",
                        hintStyle: TextStyle(color: const Color(0xFF808080)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0))),
                        contentPadding: const EdgeInsets.all(10.0)),
                  )),
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(100),
                      height: ScreenUtil.getInstance().setWidth(100),
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/ic_eye.png",
                          width: ScreenUtil.getInstance().setWidth(50),
                          height: ScreenUtil.getInstance().setWidth(50)),
                    ),
                    onTap: () {
                      setState(() {
                        obscureRePassText = !obscureRePassText;
                      });
                    },
                  )
                ],
              ),
              Container(height: ScreenUtil.getInstance().setHeight(40)),
              loginBtn,
              Expanded(
                  child: Column(
                children: <Widget>[
                  Expanded(child: loadingView),
                ],
              ))
            ],
          ),
        ));
  }

  void autoRegister(String username, String password, String rePassword) {
    setState(() {
      isOnLogin = true;
    });
    Map<String, String> map = Map();
    map["username"] = username;
    map["password"] = password;
    map["repassword"] = rePassword;
    NetUtils.post(AppUrls.POST_REGISTER, params: map).then((value) async {
      print("注册: " + value);
      var data = json.decode(value);
      if (data["errorCode"] == 0) {
        LoginEntity loginEntity = LoginEntity().fromJson(data);
        DataUtils.saveLoginInfo(loginEntity.data, username, password);
        Navigator.pop(context);
        eventBus.fire(LoginEvent());
        ToastUtils.showToast("注册成功！");
      } else {
        ToastUtils.showToast(data["errorMsg"]);
      }
    });
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    rePasswordCtrl.dispose();
    super.dispose();
  }
}
