import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/home_page.dart';
import 'package:flutter_tutorial/pages/person_page.dart';
import 'package:flutter_tutorial/pages/stop.dart';
import '../pages/home_page.dart';
import '../pages/person_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Jay Chou'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  List<Widget> _widgetOptions;
  num _selectedIndex = 0;
  bool isUserLogin = false;

  void _onItemTapped(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((data) {
      if (data.get('USERNAME') != null && data.get('PASSWORD') != null) {
        setState(() {
          this.isUserLogin = true;
        });
      } else {
        setState(() {
          this.isUserLogin = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgetOptions = <Widget>[HomePage(),Stop(), PersonPage(parentContext:context)];
    return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: _widgetOptions,
              ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('首页'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.personal_video),
                  title: Text('Jay'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('我的'),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
          )
        ;
  }
}
