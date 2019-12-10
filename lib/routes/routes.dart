import 'package:fluro/fluro.dart';
import 'package:flutter_tutorial/pages/home.dart';
import '../login.dart';
import '../pages/detail.dart';
import '../pages/home_page.dart';

class Routes {
  static Router router;
  static String login = '/login';
  static String home = '/home';
  static String detail = '/detail/:name/:desc';

  static void configureRoutes(Router router){
    router.define( login, handler: Handler(handlerFunc : (context, parameters) => Login()));
    router.define( home, handler: Handler(handlerFunc : (context, parameters) => Home()));    
    router.define( detail, handler: Handler(handlerFunc : (context, parameters){
      String name = parameters['name'].first;
      String desc = parameters['desc'].first;
      return Detail(name:name,desc:desc);
    }));

    router.notFoundHandler = Handler(
      handlerFunc: (context, parameters) => HomePage()
    );
  }
}