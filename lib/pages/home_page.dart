import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/resModel/responese_model.dart';
import 'package:flutter_tutorial/utils/httpRequest.dart';
import '../routes/application.dart';
import '../stores/countModel.dart';
import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> data;
  static List lists;
  Future _fetchData() async{
    var response = await HttpUtils.request(
        '/getlists',
        method: HttpUtils.GET,
    );
    Responese res = Responese.fromJson(response);
    setState(() {
      lists = res.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: Drawer(
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          child: new ListView(
              padding: const EdgeInsets.only(),
              children: <Widget>[
                new ClipRect(
                  child: new ListTile(
                    leading: new CircleAvatar(child: new Text("A")),
                    title: new Text('admin'),
                    onTap: () => {},
                  ),
                ),
                new ListTile(
                    leading: new CircleAvatar(child: new Text("S")),
                    title: new Text('Jay Chou'),
                    subtitle:
                    new Text("Application about Jay Chou in flutter"),
                    onTap: () => {}),
                new AboutListTile(
                  icon: new CircleAvatar(child: new Text("A")),
                  child: new Text("shmilyvidian"),
                ),
              ]),
        ),
      ),
      appBar: AppBar(
          title: Text('Jay Chou'),
        ),
        body:  RefreshIndicator(
        onRefresh: () async {},
        displacement: 20.0,
        backgroundColor: Colors.blue,
        child:  RefreshIndicator(
          child: ListView.builder(
            itemCount: lists == null ? 0 : lists.length,
            itemBuilder: (BuildContext context, int index){
              var item = lists[index];
              final List<Widget> starLists =  [];
              for(var i = 0; i < ((Random().nextInt(5))).ceil()+1; i++){
                starLists.add(Icon(Icons.star, color: Colors.orange));
              }
              var isFavorite = Provider.of<Counter>(context).favorite.contains(item);
              return SizedBox(
                child: GestureDetector(
                  onTap:(){
                    Application.router.navigateTo(context, '/detail/${item['name']}/${item['desc']}').then((onValue)=>print(onValue));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Image.network(item['imgurl'], fit: BoxFit.fill,repeat:ImageRepeat.repeatX),
                            ),
                            Positioned(
                              top: 10.0,
                              left: 10.0,
                              child: Row(
                                children: starLists,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("专辑名：${item['name']}"),
                                  Container(height: 10,),
                                  Text("发行时间：${item['time']}"),
                                ],),
                              FlatButton(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite,
                                      color: isFavorite ?  Colors.red : Colors.black,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left:8.0),
                                      child: Text(isFavorite ? '取消收藏' : '添加收藏',) ,
                                    )

                                  ],
                                ),
                                onPressed: (){
                                  Provider.of<Counter>(context).addFavorite(item);
                                },
                              )
                            ],) ,
                        ),
                      ],
                    ),
                  )
                  ,) ,
              )
              ;
            },),
          onRefresh: (){},
        )
    ),
    );
  }
}