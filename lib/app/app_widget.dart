// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:engeselt_teste/app/pages/home/home_page.dart';
import 'package:engeselt_teste/app/pages/splash/splash_page.dart';
import 'package:engeselt_teste/teste/teste_de_banco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('pt', 'BR')
        ],
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: SplashPage());
  }
}
