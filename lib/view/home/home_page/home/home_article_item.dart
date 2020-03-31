import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/utils/toast.dart';
import 'package:play/widgets/common_web_page.dart';

class HomeArticleItem extends StatelessWidget {
  const HomeArticleItem({
    Key key,
    @required ArticleDataData articleList,
  }) : _articleList = articleList, super(key: key);

  final ArticleDataData _articleList;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommonWebPage(
                title: _articleList.title,
                url: _articleList.link,
              )));
        },child: Container(
          padding:
          EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _articleList.title,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _articleList.author != ""
                        ? _articleList.author
                        : _articleList.shareUser,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    _articleList.niceShareDate,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),));
  }
}