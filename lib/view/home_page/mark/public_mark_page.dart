import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/public_mark_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/widgets/common_loading.dart';

import 'public_mark_list_page.dart';

class PublicMarkPage extends StatefulWidget {
  @override
  _PublicMarkPageState createState() => _PublicMarkPageState();
}

class _PublicMarkPageState extends State<PublicMarkPage>
    with TickerProviderStateMixin {
  List<PublicMarkData> _data = List();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _data.length, vsync: this);
    NetUtils.get(AppUrls.GET_PUBLIC_NUMBER).then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      PublicMarkEntity banner = PublicMarkEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted) _data.clear();
        _data.addAll(banner.data);
        if (mounted)
          setState(() {
            _tabController = TabController(
              length: _data.length,
              vsync: this,
            );
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _data.length > 0 &&
            _tabController != null
        ? Scaffold(
            appBar: AppBar(
              title: TabBar(
                tabs: _data.map((tab) {
                  return Tab(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(tab.name),
                    ),
                  );
                }).toList(),
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                unselectedLabelStyle:
                    TextStyle(color: Colors.grey, fontSize: 18),
                labelColor: Colors.white,
                labelPadding: EdgeInsets.all(0.0),
                indicatorPadding: EdgeInsets.all(0.0),
                indicatorWeight: 2.3,
                unselectedLabelColor: Colors.white,
              ),
            ),
            body: TabBarView(controller: _tabController, children: createTabPage()),
          )
        : CommonLoading();
  }

  List<Widget> createTabPage() {
    List<Widget> widgets = new List();
    for (var projectTab in _data) {
      widgets.add(PublicMarkListPage(projectTab.id));
    }
    return widgets;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
