import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/bean/classify_project_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/view/home/home_page/home/home_article_item.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  List<ClassifyProjectData> _data = List();
  List<int> widgetList = List();
  List<Widget> pageList = List();
  TabController _tabController;
  List<ArticleDataData> _articleList = List();
  ClassifyProjectEntity _classifyProjectEntity;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;
  int _cid = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return widgetList.length > 0 &&
            pageList.length > 0 &&
            _tabController != null
        ? Scaffold(
            appBar: AppBar(
              title: TabBar(
                tabs: widgetList.map<Container>((int tab) {
                  return Container(
                    margin:
                        EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
                    child: Tab(text: _data[tab].name),
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
            body: TabBarView(controller: _tabController, children: pageList),
          )
        : CommonLoading();
  }

  void _initData() {
    _getClassify();
  }

  void _getClassify() {
    NetUtils.get(AppUrls.GET_PROJECT_CLASSIFY).then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      ClassifyProjectEntity banner = ClassifyProjectEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted) _data.clear();
        _data.addAll(banner.data);
        _classifyProjectEntity = banner;
        if (banner.data.length > 0) {
          _cid = banner.data[0].id;
          _getProjectList();
        }
      }
    });
  }

  void _onRefresh() async {
    _page = 0;
    _getProjectList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    _getProjectList();
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _getProjectList() {
    Map<String, String> map = Map();
    map["cid"] = _cid.toString();
    NetUtils.get(AppUrls.GET_PROJECT_CLASSIFY_LIST + _page.toString() + "/json",
            params: map)
        .then((value) async {
      var data = json.decode(value);
      ArticleEntity banner = ArticleEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (_page == 0) {
          _articleList.clear();
        }
        _articleList.addAll(banner.data.datas);
        for (int i = 0; i < _data.length; i++) {
          widgetList.add(i);
          pageList.add(Container(
            child: _articleList.length > 0
                ? SmartRefresher(
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      itemBuilder: (c, i) =>
                          HomeArticleItem(articleList: _articleList[i]),
                      itemCount: _articleList.length,
                    ),
                  )
                : CommonLoading(),
          ));
        }
        _tabController = TabController(length: widgetList.length, vsync: this);
        _tabController.addListener(() {
          if (_tabController.indexIsChanging) {
            _cid = _classifyProjectEntity.data[_tabController.index].id;
            _getProjectList();
          }
        });
        if (mounted) setState(() {});
      }
    });
  }
}
