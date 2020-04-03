import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/collection_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_collection_article_item.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/common_slide_button.dart';
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
                      var key = GlobalKey<SlideButtonState>();
                      return SlideButton(
                          child: CommonCollectionArticleItem(
                              articleList: _articleList[i]),
                          singleButtonWidth:
                              ScreenUtil.getInstance().setWidth(200),
                          buttons: <Widget>[
                            buildAction(key, "删除", Colors.red, () {
                              unCollectArticle(
                                  _articleList[i].id, _articleList[i].originId);
                              _articleList.removeAt(i);
                              key.currentState.close();
                            }),
                          ]);
                    },
                    itemCount: _articleList.length,
                  ),
                )
              : CommonLoading(),
        ));
  }

  //构建button
  InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
      GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
            //设置填充颜色
            color: Colors.red,
            //设置10弧度的圆角
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(4.0),
                topRight: Radius.circular(4.0)),
            //设置边框大小和颜色
            border: Border.all(
                color: Colors.red,
                width: ScreenUtil.getInstance().setWidth(10))),
        margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10.5)),
        alignment: Alignment.center,
        width: ScreenUtil.getInstance().setWidth(200),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.getInstance().setSp(38))),
      ),
    );
  }

  void unCollectArticle(int id, int originId) {
//    Map<String, String> map = Map();
//    map["originId"] = originId.toString();
//    print('originId:$originId');
    NetUtils.post(
      AppUrls.POST_UNCOLLECT_ARTICLE + originId.toString() + "/json",
    ).then((value) async {
      var data = json.decode(value);
      print("取消取消 $data");
      if (data["errorCode"] == 0) {
        ToastUtils.showToast("取消收藏成功");
        setState(() {});
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
        if (mounted) if (_page == 0) {
          _articleList.clear();
        }
        setState(() {
          _articleList.addAll(banner.data.datas);
        });
      }
    });
  }
}
