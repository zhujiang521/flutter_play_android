import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/hot_key_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {

  List<HotKeyData> _data = List();
  List<Widget> widgetList = List();
  
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索",
            style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Wrap(
        children: widgetList
      ),
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
            for(int i = 0;i<_data.length;i++){
              widgetList.add(FlatButton(onPressed: (){}, child: Text(_data[i].name)),);
            }

          });
      }
    });
  }
}
