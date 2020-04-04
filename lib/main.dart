//
// Created by ckckck on 2018/9/25.
//

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/event_bus.dart';
import 'package:play/utils/theme_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'view/home_view.dart';

void main() {
  runApp(
    OscWidget(),
  );
}

class OscWidget extends StatefulWidget {
  @override
  _OscWidgetState createState() => _OscWidgetState();
}

class _OscWidgetState extends State<OscWidget> {
  Color themeColor = ThemeUtils.currentColorTheme;

  @override
  void initState() {
    super.initState();
    DataUtils.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        eventBus.fire(ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return // 全局配置子树下的SmartRefresher,下面列举几个特别重要的属性
        RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(),
            // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
            footerBuilder: () => ClassicFooter(),
            // 配置默认底部指示器
            headerTriggerDistance: 80.0,
            // 头部触发刷新的越界距离
            springDescription:
                SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
            // 自定义回弹动画,三个属性值意义请查询flutter api
            maxOverScrollExtent: 100,
            //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
            maxUnderScrollExtent: 0,
            // 底部最大可以拖动的范围
            enableScrollWhenRefreshCompleted: true,
            //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
            enableLoadingWhenFailed: true,
            //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
            hideFooterWhenNotFull: false,
            // Viewport不满一屏时,禁用上拉加载更多功能
            enableBallisticLoad: true,
            // 可以通过惯性滑动触发加载更多
            child: MaterialApp(
              debugShowCheckedModeBanner: false, //取出debug
              theme: ThemeData(
                // Add the 3 lines from here...
                primaryColor: themeColor,
                platform: TargetPlatform.iOS, //右滑返回
              ),
              title: '玩安卓',
              home: HomeView(),
            ));
  }
}
