import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:play/bean/banner_entity.dart';
import 'package:play/widgets/common_loading.dart';
import 'package:play/widgets/common_web_page.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key key,
    @required List<BannerData> data,
  })  : _data = data,
        super(key: key);

  final List<BannerData> _data;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.getInstance().setHeight(500),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              _data[index].imagePath,
              fit: BoxFit.fill,
            );
          },
          itemCount: _data.length,
          pagination: SwiperPagination(),
          autoplay: true,
          autoplayDisableOnInteraction: true,
          onTap: (index) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CommonWebPage(
                      title: _data[index].title,
                      url: _data[index].url,
                      id: _data[index].id,
                    )));
          },
        ));
  }
}
