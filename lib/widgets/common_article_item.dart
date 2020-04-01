import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/article_entity.dart';
import 'package:play/widgets/common_web_page.dart';

class CommonArticleItem extends StatelessWidget {
  const CommonArticleItem({
    Key key,
    @required ArticleDataData articleList,
  })  : _articleList = articleList,
        super(key: key);

  final ArticleDataData _articleList;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommonWebPage(
                  title: _articleList.title,
                  url: _articleList.link,
                  id: _articleList.id,
                  collect: _articleList.collect,
                )));
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
        child: Row(
          children: <Widget>[
            _articleList.envelopePic != ""
                ? FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder.png",
                    width: ScreenUtil.getInstance().setWidth(220),
                    height: ScreenUtil.getInstance().setWidth(200),
                    image: _articleList.envelopePic,
                    fit: BoxFit.cover,
                  )
                : Container(),
            Container(
              width: _articleList.envelopePic != ""
                  ? ScreenUtil.getInstance().setWidth(760)
                  : ScreenUtil.getInstance().setWidth(980),
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _articleList.title,
                    style:
                        TextStyle(fontSize: ScreenUtil.getInstance().setSp(45)),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          _articleList.fresh != null && _articleList.fresh
                              ? Text(
                                  "最新 ",
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Container(),
                          _articleList.type != null && _articleList.type != 0
                              ? Text(
                                  "置顶 ",
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Container(),
                          _articleList.author != null &&
                                      _articleList.author != "" ||
                                  _articleList.shareUser != null &&
                                      _articleList.shareUser != ""
                              ? Text(
                                  _articleList.author != null &&
                                          _articleList.author != ""
                                      ? _articleList.author
                                      : _articleList.shareUser,
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(
                                  "收藏集",
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
                      Text(
                        _articleList.niceShareDate != null
                            ? _articleList.niceShareDate
                            : "好好学习",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
