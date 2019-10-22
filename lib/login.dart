import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/home.dart';
import 'package:flutter_tutorial/stores/countModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget{

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '登录',
      home: Scaffold(
//          resizeToAvoidBottomPadding: false, //输入框抵住键盘
          body: Container(
            child: SingleChildScrollView(
            child:  Column(
              children: <Widget>[
                Container(
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      image: new DecorationImage(
                        image: AssetImage('assets/images/login.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:32.0, horizontal: 24.0),
                  child:  Column(
                    children: <Widget>[
                      Container(
                        child: TextField(
                          controller: userController,
                          autofocus: false,
                          decoration: InputDecoration(
                              labelText: "用户名",
                              hintText: "用户名",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder()
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:16.0),
                        child: TextField(
                          controller: passwordController,
                          autofocus: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "密码",
                              hintText: "请输入密码",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder()
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:24.0),
                        width: 370,
                        height: 120,
                        child: Column(
                          children: <Widget>[
                          Container(
                          width: 370,
                           child: RaisedButton(
                              onPressed: () async{
                                SharedPreferences user = await SharedPreferences.getInstance();

                                if (userController.text.length < 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('用户名长度必须大于2'),
                                      ));
                                  return;
                                } else if (passwordController.text.length == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('请填写密码'),
                                      ));
                                  return;
                                }

                                user.setString('USERNAME', userController.text);
                                user.setString('PASSWORD', passwordController.text);
                                 Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return Home();
                                      },
                                  ));


                                store.login(userController.text, passwordController.text);

                              },
                              child: Text("登录"),
                              textColor: Colors.white,
                              color: Colors.blue,
                              highlightColor: Color(0xff00ff00),
                            )
                          ),
                            Container(
                              width: 370,
                              child: RaisedButton(
                                onPressed: () async{
                                  SharedPreferences user = await SharedPreferences.getInstance();

                                  if (userController.text.length < 2) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('用户名长度必须大于2'),
                                        ));
                                    return;
                                  } else if (passwordController.text.length == 0) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('请填写密码'),
                                        ));
                                    return;
                                  }

                                  user.setString('USERNAME', userController.text);
                                  user.setString('PASSWORD', passwordController.text);
                                  store.login(userController.text, passwordController.text);

                                },
                                child: Text("注册"),
                                textColor: Colors.blue,
                                color: Colors.white,
                                highlightColor: Color(0xff00ff00),
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
          )
        ),)
      ),
    );
  }
}