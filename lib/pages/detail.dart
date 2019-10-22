import 'package:flutter/material.dart';


class Detail extends StatelessWidget{
  String name;
  String desc;
  Detail({this.name, this.desc});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '详情',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  Scaffold(
        appBar: AppBar(
          leading: Container(
              child: RaisedButton(
                elevation: 0,
                color: Colors.orange,
                child: 
                  Icon(
                    Icons.keyboard_arrow_left,                 
                    color: Colors.white,
                  ),
                  onPressed: () {  Navigator.pop(context);},
                )),
          title: Text('详情'),
        ),
        body:Container (
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 32.0),
                child: Text("专辑名：$name"),
              ),
              Text("专辑介绍： $desc"),
            ],
        ),)
        ),
    );
  }
}
