import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/rank_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/custom_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileCoinRankingPage extends StatefulWidget {
  @override
  _ProfileCoinRankingPageState createState() => _ProfileCoinRankingPageState();
}

class _ProfileCoinRankingPageState extends State<ProfileCoinRankingPage> {
  int _page = 1;
  List<RankDataData> _data = List();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getRankingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: "排行榜"),
      body: Container(
        child: _data.length > 0
            ? SmartRefresher(
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(_data[i].username),
                          subtitle: Text(
                            '${_data[i].level}级',
                          ),
                          trailing: Text("第${_data[i].rank.toString()}名"),
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: _data.length,
                ),
              )
            : CommonLoading(),
      ),
    );
  }

  void _onRefresh() async {
    _page = 1;
    _getRankingList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    _getRankingList();
    _refreshController.loadComplete();
  }

  void _getRankingList() {
    NetUtils.get(AppUrls.GET_RANKING_LIST + _page.toString() + "/json")
        .then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      RankEntity banner = RankEntity().fromJson(data);
      if (banner.errorCode == 0) {
        if (_page == 0) _data.clear();
        _data.addAll(banner.data.datas);
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
