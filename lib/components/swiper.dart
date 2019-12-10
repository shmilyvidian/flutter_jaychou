import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperPage extends StatefulWidget {
  @override
  SwiperPageState createState() {
    return SwiperPageState();
  }
}

class SwiperPageState extends State<SwiperPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal:10.0,vertical: 2.0),
        width: MediaQuery.of(context).size.width,
        height: 210.0,
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: 3,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.black54,
            activeColor: Colors.white,
          )),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => print('点击了第$index个'),
        )
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    const List<String> imgs = [
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571842746170&di=6892405d0a317c3ede065f8c48eb0113&imgtype=0&src=http%3A%2F%2Fp4.music.126.net%2FSsvTcC_w498n0bjpkMT0BQ%3D%3D%2F1364493968318319.jpg%3Fparam%3D640y300',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571842975157&di=c6ce5295c2acb6ab3f4a7fb150ba0484&imgtype=0&src=http%3A%2F%2Fhimg2.huanqiu.com%2Fattachment2010%2F2016%2F0211%2F20%2F59%2F20160211085944707.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571842975156&di=908341c52b9d54306c1bbe8dcc84e6a9&imgtype=0&src=http%3A%2F%2Fwww.people.com.cn%2Fmediafile%2Fpic%2F20150512%2F93%2F3766747363732959941.jpg'
      ];
    return (Image.network(
      imgs[index],
      fit: BoxFit.fill,
    ));
  }
}