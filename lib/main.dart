import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_tutorial/components/splash.dart';
import './stores/userModel.dart';
import './stores/countModel.dart';
import 'package:provider/provider.dart';
import './routes/routes.dart';
import './routes/application.dart';
import './login.dart';
import './stores/index.dart' show Store;

void main() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;


  runApp(Store.init(child:MaterialApp(
      title: 'Jay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: StartApp(),
      onGenerateRoute: Application.router.generator,
    ),
  ) );
}
