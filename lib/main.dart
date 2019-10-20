import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './stores/countModel.dart';
import './pages/home_page.dart';
import './pages/person_page.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => {
  runApp(ChangeNotifierProvider<Counter>.value(
    notifier: Counter(1,List(),false),
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

class _MyHomePageState extends State<MyHomePage> {

  final List<Widget> _widgetOptions = <Widget> [
    HomePage(),
    PersonPage()
  ];
  num _selectedIndex = 0;
  bool _isLogin = false;

  void _onItemTapped(int index){
    setState(() {
      this._selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
//    SharedPreferences.getInstance().then((data) {
//      if(data.get('USERNAME') != null && data.get('PASSWORD') != null){
//        setState(() {
//          _isLogin = true;
//        });
//      }else{
//        setState(() {
//          _isLogin = false;
//        });
//      }
//    });

  }
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
    return  store.isLogin ? Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child:Container(
          margin: EdgeInsets.only(top:50.0),
          child: new ListView(padding: const EdgeInsets.only(), children: <Widget>[
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
            subtitle: new Text("Application about Jay Chou in flutter"),
            onTap: () => {},
          ),
          new AboutListTile(
            icon: new CircleAvatar(child: new Text("A")),
            child: new Text("shmilyvidian"),
          ),
        ]),
      ),
      ),
      body:  _widgetOptions[_selectedIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
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
    ) :  Login();
  }
}
