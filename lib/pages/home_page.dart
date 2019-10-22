import 'package:flutter/material.dart';
import '../stores/countModel.dart';
import 'package:provider/provider.dart';
import './detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

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
    print('ente-------');

  }
  @override
  Widget build(BuildContext context){

    return RefreshIndicator(
        onRefresh: () async {},
        displacement: 20.0,
        backgroundColor: Colors.blue,
        child:  lists == null ? Center(child: Text('loading...'),) : ListView.builder(
          itemCount: lists == null ? 0 : lists.length,
          itemBuilder: (BuildContext context, int index){
            var item = lists[index];
            
            var isFavorite = Provider.of<Counter>(context).favorite.contains(item);
            print(isFavorite);
            return SizedBox(
              child: GestureDetector(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return Detail(name:item['name'],desc: item['desc']);
                      }
                  ));
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Image.network(item['imgurl'], fit: BoxFit.fill,repeat:ImageRepeat.repeatX),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("专辑名：${item['name']}"),
                            Text("${item['time']}"),
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
    );
  }
}