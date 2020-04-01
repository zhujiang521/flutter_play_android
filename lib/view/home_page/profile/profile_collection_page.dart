import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/bean/collection_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_collection_article_item.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/custom_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileCollectionPage extends StatefulWidget {
  @override
  _ProfileCollectionPageState createState() => _ProfileCollectionPageState();
}

class _ProfileCollectionPageState extends State<ProfileCollectionPage> {
  List<CollectionDataData> _articleList = List();
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
                    itemBuilder: (c, i) {
                      return Dismissible(
                        onDismissed: (_) {
                          //参数暂时没有用到，则用下划线表示
                          unCollectArticle(_articleList[i].id,_articleList[i].originId);
                          _articleList.removeAt(i);
                        },
                        key: Key(_articleList[i].id.toString()),
                        child: CommonCollectionArticleItem(
                            articleList: _articleList[i]),
                        background: Container(
                          color: Colors.red,
                        ),
                      );
                    },
                    itemCount: _articleList.length,
                  ),
                )
              : CommonLoading(),
        ));
  }

  void unCollectArticle(int id, int originId) {
//    Map<String, String> map = Map();
//    map["originId"] = originId.toString();
//    print('originId:$originId');
    NetUtils.post(AppUrls.POST_UNCOLLECT_ARTICLE + originId.toString() + "/json",)
        .then((value) async {
      var data = json.decode(value);
      print("取消取消 $data");
      if (data["errorCode"] == 0) {
        setState(() {
          // 提示
          ToastUtils.showToast("取消收藏成功");
        });
      } else {
        // 提示
        ToastUtils.showToast("取消收藏失败");
      }
    });
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
    NetUtils.get(AppUrls.GET_COLLECT_ARTICLE + _page.toString() + "/json")
        .then((value) async {
      print("获取收藏: " + value);
      var data = json.decode(value);
      CollectionEntity banner = CollectionEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (mounted)
          setState(() {
            _articleList.addAll(banner.data.datas);
          });
      }
    });
  }
}
