import 'package:flutter/material.dart';
import 'package:play/utils/data_utils.dart';
import 'package:play/utils/event_bus.dart';
import 'package:play/utils/theme_utils.dart';



class ChangeThemePage extends StatefulWidget {
  @override
  _ChangeThemePageState createState() => _ChangeThemePageState();
}

class _ChangeThemePageState extends State<ChangeThemePage> {

  List<Color> colors = ThemeUtils.supportColors;

  changeColorTheme(Color c) {
    eventBus.fire(ChangeThemeEvent(c));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('切换主题', style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true, //设置标题是否局中
        ),
        body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(colors.length, (index) {
                return InkWell(
                  onTap: () {
                    ThemeUtils.currentColorTheme = colors[index];
                    DataUtils.setColorTheme(index);
                    changeColorTheme(colors[index]);
                  },
                  child: Container(
                    color: colors[index],
                    margin: const EdgeInsets.all(3.0),
                  ),
                );
              }),
            )
        )
    );
  }

}