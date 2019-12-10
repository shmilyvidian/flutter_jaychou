import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/components/swiper.dart';
import 'package:provider/provider.dart';
import '../stores/countModel.dart';

class Stop extends StatelessWidget {
  List<String> getDataList() {
    List<String> list = ['任务', '一键送花', '排行榜', 'VIP', '抽奖', '相册', '论坛通知', '喜欢'];
    return list;
  }

  List<Widget> getWidgetList() {
    return getDataList().asMap().keys.map((i) => getItemContainer(i, getDataList()[i])).toList();
    // return getDataList().map((item) => getItemContainer(item)).toList();
  }

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.transform), new Icon(Icons.print),
    new Icon(Icons.card_giftcard), new Icon(Icons.verified_user),
    new Icon(Icons.zoom_out_map), new Icon(Icons.alarm),
     new Icon(Icons.zoom_out_map), new Icon(Icons.favorite),
  ];

  Widget getItemContainer(i, item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 50,
          margin: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: iconItems[i],
        ),
        Text(
          item,
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('广场'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(height: 5.0),
              SwiperPage(),
              Container(
                // margin: EdgeInsets.all(16.0),
                height: 195.0,
                child: GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  //水平子Widget之间间距
                  crossAxisSpacing: 20.0,
                  //垂直子Widget之间间距
                  mainAxisSpacing: 15.0,
                  //GridView内边距
                  padding: EdgeInsets.symmetric(vertical: 10),
                  //一行的Widget数量
                  crossAxisCount: 4,
                  //子Widget宽高比例
                  childAspectRatio: 1.1,
                  //子Widget列表
                  children: getWidgetList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      color: Colors.orange,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '你的收藏',
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                height: 500,
                child: (store.favorite.length == 0
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: Text('暂无喜欢，你可以从首页添加收藏哟。'),
                      )
                    : ListView.builder(
                        itemCount: store.favorite.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = store.favorite[index];
                          return (Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 60,
                                margin: EdgeInsets.only(top: 10.0, right: 24.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Image.network(
                                  item['imgurl'],
                                  height: 60,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('专辑名： ${item['name']}'),
                                  Text('发行时间： ${item['time']}'),
                                ],
                              )
                            ],
                          ));
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
