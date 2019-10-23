import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/routes/application.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../stores/countModel.dart';

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
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
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
                              '${store.getUser['username'] ??= 'shmilyvidian'}'),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.verified_user,
                                color: Colors.red,
                              ),
                              Text('您也是周杰伦粉丝成员之一哟')
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 24.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.orangeAccent, // 底色
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('688'),
                        Row(children:<Widget>[ Icon(Icons.face),Text('好友'),])
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('688'),
                        Row(children:<Widget>[ Icon(Icons.face),Text('影响力'),])
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('2388'),
                        Row(children:<Widget>[ Icon(Icons.face),Text('今日人气'),])
                      ],
                    )
                  ],
                ),
                )
                ,
                Container(
                  height: 400,
                  margin: EdgeInsets.only(top:10.0),
                  child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                        title: Text('收藏'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ),
                      ListTile(
                        title: Text('设置'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ),
                      ListTile(
                        title: Text('帮助'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ),
                      ListTile(
                        title: Text('版本'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ),
                     
                    ]).toList(),
                  ),
                ),
              ],
            )),
      ),
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
