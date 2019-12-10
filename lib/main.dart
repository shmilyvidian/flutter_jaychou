import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_tutorial/components/splash.dart';
import 'package:flutter_tutorial/utils/locale_util.dart';
import 'package:flutter_tutorial/utils/translations.dart';
import './routes/routes.dart';
import './routes/application.dart';
import './stores/index.dart' show Store;
import 'package:flutter_localizations/flutter_localizations.dart';
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
    localizationsDelegates: [
      const TranslationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: localeUtil.supportedLocales(),
      home: StartApp(),
      onGenerateRoute: Application.router.generator,
    ),
  ) );
}
