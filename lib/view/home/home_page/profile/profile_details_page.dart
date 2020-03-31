import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:play/bean/login_entity.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/custom_app_bar.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  LoginData _userInfo;

  _getDetailInfo() {
    DataUtils.getUserInfo().then((login) {
      setState(() {
        _userInfo = login;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: '我的资料'),
      body: buildSingleChildScrollView(),
    );
  }

  File _image;

  /// 头像更新
  Future<void> _portraitUpdate() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Widget buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: _userInfo == null
          ? CommonLoading()
          : Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _portraitUpdate();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '头像',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            image: DecorationImage(
                              image: _image == null
                                  ? NetworkImage(_userInfo.icon)
                                  : FileImage(_image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '昵称',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          _userInfo.nickname,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '电子邮箱',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.email,
                        // _userInfo.joinTime.split(' ')[0],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '密码',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          _userInfo.password,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            '公开名称',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // 'Android,C/C++,J2ME/K-Java,Python,.NET/C#',
                            _userInfo.publicName,
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            '类型',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // '手机软件开发，服务器开发，软件开发管理',
                            _userInfo.type.toString(),
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '用户名称',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.username,
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
    );
  }
}
