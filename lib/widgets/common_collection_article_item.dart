import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/bean/collection_entity.dart';
import 'package:play/widgets/common_web_page.dart';

class CommonCollectionArticleItem extends StatelessWidget {
  const CommonCollectionArticleItem({
    Key key,
    @required CollectionDataData articleList,
  })  : _articleList = articleList,
        super(key: key);

  final CollectionDataData _articleList;

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
                  collect: false,
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
                  Html(
                    data: _articleList.title,
                    customTextStyle: (node, TextStyle baseStyle) {
                      return  baseStyle
                          .merge(TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)));
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                           Text(
                                  "收藏集",
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
                      Text("只要开始，永远不晚",
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
