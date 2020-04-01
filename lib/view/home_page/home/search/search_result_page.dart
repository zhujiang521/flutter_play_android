import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/bean/search_article_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/custom_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home_article_item.dart';

class SearchResultPage extends StatefulWidget {
  String name;

  SearchResultPage(String name) {
    this.name = name;
  }

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  int _page = 0;
  List<ArticleDataData> _articleList = List();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    searchArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: widget.name),
      body: Container(
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
      ),
    );
  }

  void _onRefresh() async {
    _page = 0;
    searchArticleList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    searchArticleList();
    _refreshController.loadComplete();
  }

  void searchArticleList() {
    Map<String, String> map = Map();
    map["k"] = widget.name;
    NetUtils.post(AppUrls.POST_QUERY_KEY + _page.toString() + "/json",
            params: map)
        .then((value) async {
      var data = json.decode(value);
      SearchArticleEntity banner = SearchArticleEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted)
          setState(() {
            if (_page == 0) {
              _articleList.clear();
            }
            _articleList.addAll(banner.data.datas);
          });
      }
    });
  }
}
