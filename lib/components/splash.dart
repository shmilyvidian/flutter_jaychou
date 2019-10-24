import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tutorial/routes/application.dart';




class StartApp extends StatefulWidget{
    _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp>with SingleTickerProviderStateMixin{

    var loginState;

    AnimationController _animationController;
    Animation _animation;

    void initState(){
        super.initState();
        //创建动画控制器
        _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 5000));
        _animation = Tween(begin: 1.0,end: 1.0).animate(_animationController);
        _animation.addStatusListener((status){
            if(status == AnimationStatus.completed){
                Application.router.navigateTo(context, 'login');
            }
        });
        _animationController.forward();
    }

    @override
    void dispose(){
        _animationController.dispose();
        super.dispose();
    }
    
    @override
    Widget build(BuildContext context){
        return FadeTransition(
            opacity: _animation,
            child: ConstrainedBox(
                //让他的child充满整个屏幕
                constraints: BoxConstraints.expand(),
                child: Stack(
                    children: <Widget>[
                         Container(
                             height:double.infinity,
                             //这边放一张图用于显示5秒的底图，这张图和上面的图一样，这样就有连贯起来的效果了
                             child: Image.asset(
                                 'assets/images/splash.png',
                                 scale:1.0,
                                 fit:BoxFit.fill
                             ),
                         ),
                        Positioned(
                            top: 50.0,
                            right: 20.0,
                            child: FlatButton(
                                color: Colors.green,
                                highlightColor: Colors.blue,
                                colorBrightness: Brightness.dark,
                                splashColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Text("跳过"),
                                onPressed: (){
                                    _animationController.dispose();
                                    Application.router.navigateTo(context, 'login');
                                },
                            ),
                        )
                    ],
                )
            )
        );
    }
}