import 'dart:ui';
import 'package:flutter/material.dart';
import '../stores/countModel.dart';
import 'package:provider/provider.dart';
import '../login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PersonSetting(),
    );
  }
}

class PersonSetting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
    return Scaffold(
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/headPicture.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${store.getUser['username']??='shmilyvidian'}'),
                        Row(
                          children: <Widget>[
                            Icon(Icons.verified_user),
                            Text('您也是周杰伦粉丝成员之一哟')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:24.0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.list, color: Colors.orange,),
                    Text('你的收藏', textAlign: TextAlign.left,)
                  ],
                ),
              ),
              Container(
                height: 300,
                child: (
                    ListView.builder(
                        itemCount: Provider.of<Counter>(context).favorite.length,
                        itemBuilder: (BuildContext context, int index){
                          var item = Provider.of<Counter>(context).favorite[index];
                          return(
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                                 Container(
                                   width:90,
                                   height:60,
                                   margin: EdgeInsets.only(top: 10.0, right: 24.0),
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Colors.grey, width: 1.0),
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
                             )
                          );
                        })
                ),
              )

            ],
          )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          SharedPreferences user = await SharedPreferences.getInstance();
          user.remove('USERNAMEW');
          user.remove('PASSWORD');
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context){
                return Login();
              }
            ));
          },
        child: Text('退出'),
      ) ,
    );
  }
}