import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/hot_key_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_loading.dart';

import 'search_result_page.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  final searchKeyCtrl = TextEditingController(text: '');
  List<HotKeyData> _data = List();
  List<Widget> widgetList = List();
  List<Widget> commonList = List();

  @override
  void initState() {
    super.initState();
    commonList.add(CommonLoading());
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(25)),
          child: Wrap(children: _data.length > 0 ? widgetList : commonList),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            height: ScreenUtil.getInstance().setWidth(100),
            child: TextField(
              controller: searchKeyCtrl,
              decoration: InputDecoration(
                  hintText: " 请输入搜索关键字",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.getInstance().setSp(40)),
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(4.0))),
                  contentPadding: const EdgeInsets.all(4.0)),
            ),
          )),
          InkWell(
            child: Container(
              margin:
                  EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(25)),
              width: ScreenUtil.getInstance().setWidth(200),
              height: ScreenUtil.getInstance().setWidth(200),
              alignment: Alignment.center,
              child: Text(
                '搜索',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(48),
                    color: Colors.white),
              ),
            ),
            onTap: () {
              if (searchKeyCtrl.text.trim().isEmpty) {
                ToastUtils.showToast("搜索关键字不能为空");
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchResultPage(searchKeyCtrl.text.trim())));
            },
          )
        ],
      ),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.1,
    );
  }

  void _initData() {
    NetUtils.get(AppUrls.GET_SEARCH_HOT_KEY).then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      HotKeyEntity banner = HotKeyEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted)
          setState(() {
            _data.clear();
            _data.addAll(banner.data);
            for (int i = 0; i < _data.length; i++) {
              widgetList.add(
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(20),
                      right: ScreenUtil.getInstance().setWidth(20),
                      top: ScreenUtil.getInstance().setWidth(20)),
                  child: FlatButton(
                    color: ThemeUtils.currentColorTheme,
                    highlightColor: ThemeUtils.currentColorTheme,
                    colorBrightness: Brightness.dark,
                    splashColor: ThemeUtils.currentColorTheme,
                    child: Text(_data[i].name),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ScreenUtil.getInstance().setWidth(20))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchResultPage(_data[i].name)));
                    },
                  ),
                ),
              );
            }
          });
      }
    });
  }
}
