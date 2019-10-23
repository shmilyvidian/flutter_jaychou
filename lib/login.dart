import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/home.dart';
import 'package:flutter_tutorial/stores/countModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './routes/application.dart';
import './stores/index.dart' show Store;
import './stores/userModel.dart';
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
                  child: ClipPath (
                    clipper: BottomClipper(),
                    child: Container (
                      height: 240,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        image: new DecorationImage(
                          image: AssetImage('assets/images/login.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal: 24.0),
                  child:  Column(
                    children: <Widget>[
                      Container(
                        child: TextField(
                          controller: userController,
                          autofocus: true,
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
                      Store.connect<User>(builder: (context, snapshot, child){
                        return Container(
                        width: 370,
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: 
                          Container(
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
                                Application.router.navigateTo(context, '/home');
                                
                                snapshot.login(userController.text, passwordController.text);
                              },
                              child: Text("登录"),
                              textColor: Colors.white,
                              color: Colors.blue,
                              highlightColor: Color(0xff00ff00),
                            )
                          ),),
                          Container(width: 24,),
                           Expanded(
                            flex: 1,
                            child: 
                            Container(
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
                            ),)

                          ],
                        ),
                      );
                      }
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

class BottomClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height-30.0); //第2个点
    var firstControlPoint = Offset(size.width/2, size.height);
    var firstEdnPoint = Offset(size.width, size.height-30.0);
    path.quadraticBezierTo(
      firstControlPoint.dx, 
      firstControlPoint.dy, 
      firstEdnPoint.dx, 
      firstEdnPoint.dy
    );
    path.lineTo(size.width, size.height-30.0); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}