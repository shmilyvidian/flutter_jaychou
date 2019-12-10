import 'package:flutter/material.dart';
import 'package:flutter_tutorial/stores/countModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import './routes/application.dart';
import './stores/index.dart' show Store;
import './stores/userModel.dart';
import 'package:flutter/animation.dart';

class Login extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() {
    // TODO: implement createState
    return _ScaleAnimationRouteState();
  }
}

class _ScaleAnimationRouteState extends State<Login>
    with SingleTickerProviderStateMixin {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Animation animation, delayedAnimation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = new Tween(begin: 100.0, end: 240.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)))
      ..addListener(() {
        setState(() {});
      });
//    ..addListener(() {
//    setState(() {
//    // the state that has changed here is the animation object’s value
//    });
//    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Counter>(context);
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '登录',
      home: Scaffold(
//          resizeToAvoidBottomPadding: false, //输入框抵住键盘
          body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
                child: ClipPath(
                    clipper: BottomClipper(),
                    child: AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, child) {
                          return Container(
                            height: animation.value,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              image: new DecorationImage(
                                image: AssetImage('assets/images/login.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }))),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      controller: userController,
                      autofocus: false,
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: TextField(
                      controller: passwordController,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "请输入密码",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Store.connect<User>(builder: (context, snapshot, child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0.0, 0.0),
                      child: Container(
                        width: 370,
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      SharedPreferences user =
                                          await SharedPreferences.getInstance();

                                      if (userController.text.length < 2) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text('用户名长度必须大于2'),
                                                ));
                                        return;
                                      } else if (passwordController
                                              .text.length ==
                                          0) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text('请填写密码'),
                                                ));
                                        return;
                                      }

                                      var res = await snapshot.login(userController.text,
                                          passwordController.text, 0);
                                      if(res == null){
                                        Toast.show("用户未注册！请先完成注册", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                        return;
                                      }
                                      user.setString(
                                          'USERNAME', userController.text);
                                      user.setString(
                                          'PASSWORD', passwordController.text);
                                      controller.dispose();
                                      Application.router
                                          .navigateTo(context, '/home');
                                    },
                                    child: Text("登录"),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    highlightColor: Color(0xff00ff00),
                                  )),
                            ),
                            Container(
                              width: 24,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () async {
                                    SharedPreferences user =
                                        await SharedPreferences.getInstance();

                                    if (userController.text.length < 2) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('用户名长度必须大于2'),
                                              ));
                                      return;
                                    } else if (passwordController.text.length ==
                                        0) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('请填写密码'),
                                              ));
                                      return;
                                    }
                                    var res = await snapshot.login(userController.text,
                                          passwordController.text,1);
                                      if(res == null){
                                        Toast.show("用户未注册！", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                        return;
                                      }else{
                                                                                Toast.show("用户未注册！", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                       Toast.show("用户注册成功！", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);

                                      }
                                    user.setString(
                                        'USERNAME', userController.text);
                                    user.setString(
                                        'PASSWORD', passwordController.text);
                          
                                    controller.dispose();
                                    Application.router
                                        .navigateTo(context, '/home');
                                  },
                                  child: Text("注册"),
                                  textColor: Colors.blue,
                                  color: Colors.white,
                                  highlightColor: Color(0xff00ff00),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        )),
      )),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - 30.0); //第2个点
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEdnPoint = Offset(size.width, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEdnPoint.dx, firstEdnPoint.dy);
    path.lineTo(size.width, size.height - 30.0); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
