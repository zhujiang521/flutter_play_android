import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:play/utils/toast.dart';

class CommonWebPage extends StatefulWidget {
  final String title;
  final String url;
  final int id;
  final bool collect;

  CommonWebPage({Key key, this.title, this.url, this.id, this.collect})
      : assert(title != null),
        assert(url != null),
        assert(id != null),
        super(key: key);

  @override
  _CommonWebPageState createState() => _CommonWebPageState();
}

class _CommonWebPageState extends State<CommonWebPage> {
  List<Map<String, Object>> list = List();
  bool isLoading = true;
  bool isDialog = false;
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  String collect = "收藏";

  @override
  void initState() {
    super.initState();
    if (widget.collect != null && widget.collect) {
      collect = "取消收藏";
    }

    //监听url变化
    _flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    list.clear();
    list
      ..add({
        "title": collect,
        "icon": collect == "收藏" ? Icons.favorite_border : Icons.favorite
      })
      ..add({"title": "复制链接", "icon": Icons.link})
      ..add({"title": "浏览器打开", "icon": Icons.open_in_browser})
      ..add({"title": "微信分享", "icon": Icons.share})
      ..add({"title": "刷新", "icon": Icons.refresh});

    List<Widget> _appBarTitle = [
      Container(
          width: isLoading
              ? ScreenUtil.getInstance().setWidth(640)
              : ScreenUtil.getInstance().setWidth(720),
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          )
          /* Html(
          data: widget.title,
          customTextStyle: (node, TextStyle baseStyle) {
            return baseStyle.merge(TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(52),
              color: Colors.white,
//              overflow: TextOverflow.ellipsis,
//              softWrap: true,
            ));
          },
        ),*/
          ),
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(20),
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
        iconTheme: IconThemeData(color: Colors.white), //0412
        actions: actions(context), // added
      ),
      withJavascript: true,
      //允许执行js
      withLocalStorage: true,
      //允许本地存储
      withZoom: true,
      //允许网页缩放
      bottomNavigationBar: Visibility(
        child: container(),
        visible: isDialog,
      ),
    );
  }

  List<Widget> actions(BuildContext context) {
    return <Widget>[
      widget.id != -1
          ? GestureDetector(
              onTap: () {
                // 显示底部弹框

                //showBottomSheet(context);

                setState(() {
                  isDialog = true;
                });
              },
              child: Container(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(Icons.more_vert),
              ),
            )
          : Container(),
    ];
  }

  Container container() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(600),
      color: Colors.black12,
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: createBottomSheetItem(
                list[index]['title'], list[index]['icon']),
            onTap: () {
              //Navigator.pop(context);
              handleBottomSheetItemClick(context, index);
            },
          );
        },
        itemCount: list.length,
      ),
    );
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return container();
      },
    );
  }

  createBottomSheetItem(String title, IconData icon) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: ScreenUtil.getInstance().setHeight(20),
            bottom: ScreenUtil.getInstance().setHeight(20),
          ),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: ThemeUtils.currentColorTheme,
            size: 32,
          ),
        ),
        Text(
          title,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void handleBottomSheetItemClick(context, index) {
    setState(() {
      isDialog = false;
    });
    switch (index) {
      case 0:
        addArticleFavorite();
        break;
      case 1:
        copyLink();
        break;
      case 2:
        openByBrowser();
        break;
      case 3:
        shareWeChat();
        break;
      case 4:
        refresh();
        break;
    }
  }

  /// 添加收藏
  void addArticleFavorite() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        collectArticle();
      } else {
        ToastUtils.showToast("请先登录！");
      }
    });
  }

  void collectArticle() {
    NetUtils.post(collect == "收藏"
            ? AppUrls.POST_COLLECT_ARTICLE + widget.id.toString() + "/json"
            : AppUrls.POST_UNCOLLECT_ARTICLE + widget.id.toString() + "/json")
        .then((value) async {
      var data = json.decode(value);
      if (data["errorCode"] == 0) {
        setState(() {
          collect = collect == "收藏" ? "取消收藏" : "收藏";
          ToastUtils.showToast("${collect == "收藏" ? "取消收藏" : "收藏"}成功");
        });
      } else {
        ToastUtils.showToast("$collect失败");
      }
      print("$collect$value");
    });
  }

  /// 复制链接
  void copyLink() {
    ClipboardData data = new ClipboardData(text: widget.url);
    Clipboard.setData(data);
    ToastUtils.showToast("复制成功");
  }

  /// 从浏览器打开
  void openByBrowser() async {
//    if (await canLaunch(widget.url)) {
//      await launch(widget.url);
//    } else {
//      throw 'Could not launch $widget.url';
//    }
    ToastUtils.showToast("跳转失败，可尝试复制链接并打开");
  }

  /// 分享到微信
  void shareWeChat() {}

  /// 刷新
  void refresh() {}
}
