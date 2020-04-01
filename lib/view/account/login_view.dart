import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play/bean/login_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/event_bus.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_button.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameCtrl = TextEditingController(text: '');
  final passwordCtrl = TextEditingController(text: '');

  // 是否隐藏输入的文本
  bool obscureText = true;

  // 是否正在登录
  bool isOnLogin = false;

  @override
  Widget build(BuildContext context) {
    var loginBtn = Builder(builder: (ctx) {
      return CommonButton(
          text: "登录",
          onTap: () {
            if (isOnLogin) return;
            // 拿到用户输入的账号密码
            String username = usernameCtrl.text.trim();
            String password = passwordCtrl.text.trim();
            if (username.isEmpty || password.isEmpty) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text("账号和密码不能为空！"),
              ));
              return;
            }
            // 关闭键盘
            FocusScope.of(context).requestFocus(FocusNode());
            autoLogin(username, password);
          });
    });

    var loadingView;
    if (isOnLogin) {
      loadingView = Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[CupertinoActivityIndicator(), Text("登录中，请稍等...")],
        ),
      ));
    } else {
      loadingView = Center();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("登录", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Center(child: Text("请使用玩安卓帐号密码登录")),
              Container(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("用户名："),
                  Expanded(
                      child: TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                        hintText: "请输入登录账户",
                        hintStyle: TextStyle(color: const Color(0xFF808080)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0))),
                        contentPadding: const EdgeInsets.all(10.0)),
                  )),
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.clear,
                        size: 20,
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
              Container(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("密　码："),
                  Expanded(
                      child: TextField(
                    controller: passwordCtrl,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        hintText: "请输入登录密码",
                        hintStyle: TextStyle(color: const Color(0xFF808080)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0))),
                        contentPadding: const EdgeInsets.all(10.0)),
                  )),
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/ic_eye.png",
                          width: 20, height: 20),
                    ),
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                ],
              ),
              Container(height: 20.0),
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

  void autoLogin(String username, String password) async {
    setState(() {
      isOnLogin = true;
    });
    Map<String, String> map = Map();
    map["username"] = username;
    map["password"] = password;
    NetUtils.post(AppUrls.POST_LOGIN, params: map).then((value) async {
      print("登录: " + value);
      var data = json.decode(value);
      if (data["errorCode"] == 0) {
        LoginEntity loginEntity = LoginEntity().fromJson(data);
        DataUtils().saveLoginInfo(loginEntity.data,username,password);
        Navigator.pop(context);
        eventBus.fire(LoginEvent());
        ToastUtils.showToast("登录成功！");
      } else {
        ToastUtils.showToast("账号密码不匹配！");
      }
    });
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

}
