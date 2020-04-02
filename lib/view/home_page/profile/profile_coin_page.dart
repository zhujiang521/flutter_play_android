import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:play/bean/coin_entity.dart';
import 'package:play/costants/contants.dart';
import 'package:play/utils/net_utils.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/custom_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileCoinPage extends StatefulWidget {
  @override
  _ProfileCoinPageState createState() => _ProfileCoinPageState();
}

class _ProfileCoinPageState extends State<ProfileCoinPage> {

  int _page = 1;
  List<CoinDataData> _data = List();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getCoinList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: "我的积分"),
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
                    title: Text(_data[i].userName),
                    subtitle: Text(_data[i].desc,
                    ),
                    trailing: Text("加${_data[i].coinCount.toString()}分"),
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
    _getCoinList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    _getCoinList();
    _refreshController.loadComplete();
  }

  void _getCoinList() {
    NetUtils.get(AppUrls.GET_COIN_LIST + _page.toString() + "/json")
        .then((value) async {
      print("home_page: " + value);
      var data = json.decode(value);
      CoinEntity banner = CoinEntity().fromJson(data);
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
