import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/login.dart';
import 'package:flutter_tutorial/routes/application.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../stores/countModel.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonPage extends StatelessWidget {
  final BuildContext parentContext;
  PersonPage({this.parentContext});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PersonSetting(parentContext: this.parentContext),
    );
  }
}

class PersonSetting extends StatelessWidget {
  final BuildContext parentContext;
  PersonSetting({this.parentContext});
  Widget buildListData(BuildContext context, String titleItem, Icon iconItem, String subTitleItem) {
    return new ListTile(
      leading: iconItem,
      title: new Text(
        titleItem,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: new Text(
        subTitleItem,
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text(
                '点赞',
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
              ),
              content: new Text('为周杰伦加油:$titleItem'),
            );
          },
        );
      },

    );
  }

  // 数据源
  List<String> titleItems = <String>[
    '为周杰伦打call', '歌词接龙',
    '给周杰伦送花', '送花加经验',
    '每日签到','深圳演唱会预售中'
  ];

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.favorite), new Icon(Icons.print),
    new Icon(Icons.card_giftcard), new Icon(Icons.pages),
    new Icon(Icons.zoom_out_map), new Icon(Icons.alarm),
  ];

  List<String> subTitleItems = <String>[
    '今天你为周杰伦点赞了吗？', '你对周杰伦的歌词多熟悉？',
    '每日送花，向周杰伦表达爱意', '每送花一人加50经验',
    '每日签到有奖励', '多久没去现场听歌了'
  ];

   
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
     List<Widget> _list = [];
    for (int i = 0; i < titleItems.length; i++) {
      _list.add(buildListData(context, titleItems[i], iconItems[i], subTitleItems[i]));
    }
    // 分割线
    var divideTiles = ListTile.divideTiles(context: context, tiles: _list).toList();
    return Scaffold(
//      appBar: AppBar(
//        title: Text('个人中心'),
//      ),
      body: SingleChildScrollView(
          child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              height: 280,
              color: Colors.lightBlue,
            ),
          ),
          Positioned(
            top: 60.0,
            left: 24.0,
            child: (Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/headPicture.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${store.getUser['username'] ??= 'shmilyvidian'}',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.verified_user,
                              color: Colors.red,
                            ),
                            Text(
                              '您也是周杰伦粉丝成员之一哟',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
          ),
          Positioned(
            top: 130,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: Text(
                          '我的空间',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.developer_board, color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child:
                            Text('我的广场', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.insert_comment, color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child:
                            Text('我的消息', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite, color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child:
                            Text('我的收藏', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 215.0, 20.0, 0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 6.0,
                      spreadRadius: 1.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                   Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    height: 550,
                    child:  ListView.separated(
                        itemBuilder: (context, item) {
                          return buildListData(context, titleItems[item], iconItems[item], subTitleItems[item]);
                        },
                        separatorBuilder: (BuildContext context, int index) => new Divider(),
                        itemCount: iconItems.length
                    ),  
                  ),
                //  ListView(
                //       physics: new NeverScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       padding: EdgeInsets.all(0.0),
                //       children: ListTile.divideTiles(context: context, tiles: [
                //         ListTile(
                //           title: Text('个人收藏'),
                //           trailing: Icon(Icons.keyboard_arrow_right),
                //           contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                //         ),
                //         ListTile(
                //           title: Text('设置'),
                //           trailing: Icon(Icons.keyboard_arrow_right),
                //           contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                //         ),
                //         ListTile(
                //           title: Text('帮助'),
                //           trailing: Icon(Icons.keyboard_arrow_right),
                //           contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                //           onTap: () async {
                //             String url = 'tel:18129957362';
                //             //判断是否可以拨打电话
                //             if (await canLaunch(url)) {
                //               await launch(url);
                //             } else {
                //               throw '手机号异常，不能拨打电话';
                //             }
                //           },
                //         ),
                //         Listener(
                //           child: ListTile(
                //             title: Text('版本'),
                //             trailing: Icon(Icons.keyboard_arrow_right),
                //             contentPadding:
                //                 EdgeInsets.symmetric(horizontal: 0.0),
                //           ),
                //           onPointerDown: (event) => print('down $event'),
                //           onPointerUp: (event) => print('up $event'),
                //           onPointerMove: (event) => print('move $event'),
                //           onPointerCancel: (event) => print('cancel $event'),
                //         )
                //       ]).toList(),
                //     ),
                 
                ],
              )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences user = await SharedPreferences.getInstance();
          user.remove('USERNAMEW');
          user.remove('PASSWORD');
          store.setLogin(false);

          Application.router.navigateTo(this.parentContext, '/login');
        },
        child: Text('退出'),
      ),
    );
  }
}
