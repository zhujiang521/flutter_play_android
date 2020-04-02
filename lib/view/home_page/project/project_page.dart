import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/classify_project_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/widgets/common_loading.dart';

import 'project_list_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  List<ClassifyProjectData> _data = List();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getClassify();
    _tabController = TabController(length: _data.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _data.length > 0 && _tabController != null
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
                indicatorSize: TabBarIndicatorSize.tab,
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
            body: TabBarView(
                controller: _tabController, children: createTabPage()),
          )
        : CommonLoading();
  }

  List<Widget> createTabPage() {
    List<Widget> widgets = new List();
    for (var projectTab in _data) {
      widgets.add(ProjectListPage(projectTab.id));
    }
    return widgets;
  }

  void _getClassify() {
    NetUtils.get(AppUrls.GET_PROJECT_CLASSIFY).then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      ClassifyProjectEntity banner = ClassifyProjectEntity().fromJson(data);
      if (banner.errorCode == 0) {
        _data.clear();
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
