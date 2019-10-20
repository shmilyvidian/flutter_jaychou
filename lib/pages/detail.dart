import 'package:flutter/material.dart';
import '../stores/countModel.dart';
import 'package:provider/provider.dart';

class Detail extends StatelessWidget{
  String name;
  String desc;
  Detail({this.name, this.desc});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Counter store = Provider.of<Counter>(context);
    return MaterialApp(
      title: '详情',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  Scaffold(
        appBar: AppBar(
          title: Text('详情'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left),
                tooltip: '返回',
                onPressed: () {
                  Navigator.pop(context);
                },
            ),
          ]
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
