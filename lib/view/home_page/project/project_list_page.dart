import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/view/home_page/home/home_article_item.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectListPage extends StatefulWidget {
  int id;

  ProjectListPage(int cid) {
    this.id = cid;
  }

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  List<ArticleDataData> _articleList = List();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
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

  void _getProjectList() {
    Map<String, String> map = Map();
    map["cid"] = widget.id.toString();
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
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

}
