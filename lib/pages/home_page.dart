import 'package:flutter/material.dart';
import '../routes/application.dart';
import '../stores/countModel.dart';
import 'package:provider/provider.dart';
import './detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Map data;
  static List lists;

  Future _fetchData() async{
    try {
      http.Response response = await http.get("https://www.fastmock.site/mock/ea1ca5ef5df2f1225b6c3e502c1772b6/shmilyvidian/lists");
      data = json.decode(response.body);

      setState(() {
        lists = data['data']['lists'];
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context){
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('Jay Chou'),
        ),
        body:  RefreshIndicator(
        onRefresh: () async {},
        displacement: 20.0,
        backgroundColor: Colors.blue,
        child:  lists == null ? Center(child: Text('loading...'),) : ListView.builder(
          itemCount: lists == null ? 0 : lists.length,
          itemBuilder: (BuildContext context, int index){
            var item = lists[index];
            final List<Widget> starLists =  [];
            print(Random().nextInt(5).ceil());
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
          },)
    ),
    );
  }
}