import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/detail.dart';
import 'package:flutter_tutorial/pages/home.dart';
import 'package:provider/provider.dart';
import './stores/countModel.dart';
import 'login.dart';

void main() => {
      runApp(ChangeNotifierProvider<Counter>.value(
        notifier: Counter(1, List(), false),
        child: MyApp(),
      ))
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Login(),
      routes: {
        '/login':(BuildContext context) => Login(),
        '/detail':(BuildContext context) => Detail(),
        '/home': (BuildContext context) => Home(),
      },
      initialRoute: '/login',
    );
  }
}
