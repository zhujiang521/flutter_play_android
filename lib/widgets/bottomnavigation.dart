import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'navigationiconbean.dart';

class BottomNavigationWidget extends StatefulWidget {
  ValueChanged tapCallBaack;

  BottomNavigationWidget(this.tapCallBaack);

  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationWidgetState();
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews; // 底部图标按钮区域

  // 定义一个空的设置状态值的方法
  void _rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // 初始化导航图标
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
          icon: new Icon(Icons.home), title: new Text("首页"), vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.perm_contact_calendar), title: new Text("项目"), vsync: this),
      // vsync 默认属性和参数
      new NavigationIconView(
          icon: new Icon(Icons.account_balance_wallet), title: new Text("体系"), vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.person), title: new Text("我的"), vsync: this),
    ];
    // 给每一个按钮区域加上监听
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
    返回一个脚手架，里面包含两个属性，一个是底部导航栏，另一个就是主体内容
     */
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(190),
      color: Colors.red,
      child: BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationIconView) =>
        navigationIconView.item)
            .toList(), // 添加 icon 按钮
        currentIndex: _currentIndex, // 当前点击的索引值
        type: BottomNavigationBarType.fixed, // 设置底部导航工具栏的类型：fixed 固定
        onTap: (int index) {
          // 添加点击事件
          setState(() {
            // 点击之后，需要触发的逻辑事件
            _currentIndex = index;
            widget.tapCallBaack(_currentIndex);
          });
        },
      )
    );
  }
}
