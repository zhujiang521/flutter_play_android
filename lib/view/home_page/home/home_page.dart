import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/bean/banner_entity.dart';
import 'package:play/bean/top_article_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_article_item.dart';
import 'home_banner.dart';
import 'search/home_search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerData> _data = List();
  List<ArticleDataData> _articleList = List();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => HomeSearchPage()),
                );
              })
        ],
      ),
      body: Column(
        children: <Widget>[HomeBanner(data: _data), _buildArticleList()],
      ),
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

  void _initData() {
    _getBanner();
    _getArticleList();
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

  void _getBanner() {
    NetUtils.get(AppUrls.GET_BANNER).then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      BannerEntity banner = BannerEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted)
          setState(() {
            _data.clear();
            _data.addAll(banner.data);
            print("home_page  " + _data.length.toString());
          });
      }
    });
  }

  void _getArticleList() {
    NetUtils.get(AppUrls.GET_TOP_ARTICLE_LIST)
        .then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      TopArticleEntity banner = TopArticleEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (_page == 0) {
          _articleList.clear();
          _articleList.addAll(banner.data);
        }
        print("home_page  " + _data.length.toString());
      }
    });
    NetUtils.get(AppUrls.GET_ARTICLE_LIST + _page.toString() + "/json")
        .then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      ArticleEntity banner = ArticleEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted)
          setState(() {
            _articleList.addAll(banner.data.datas);
            print("home_page  " + _data.length.toString());
          });
      }
    });
  }
}
