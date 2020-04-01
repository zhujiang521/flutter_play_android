import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/view/home_page/home/home_article_item.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/custom_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileCollectionPage extends StatefulWidget {
  @override
  _ProfileCollectionPageState createState() => _ProfileCollectionPageState();
}

class _ProfileCollectionPageState extends State<ProfileCollectionPage> {

  List<ArticleDataData> _articleList = List();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: '我的收藏'),
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
      )
    );
  }

  Expanded _buildArticleList() {
    return Expanded(
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
    _getArticleList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    _getArticleList();
    _refreshController.loadComplete();
  }

  void _getArticleList() {
    NetUtils.getAndCookies(AppUrls.GET_COLLECT_ARTICLE + _page.toString() + "/json")
        .then((value) async {
      print("获取收藏: " + value);
      var data = json.decode(value);
      ArticleEntity banner = ArticleEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted)
          setState(() {
            _articleList.addAll(banner.data.datas);
          });
      }
    });
  }


}
