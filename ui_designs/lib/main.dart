import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_designs/pages/basic_page.dart';
import 'package:ui_designs/pages/blur_gradient_page.dart';
import 'package:ui_designs/pages/scroll_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent,)
    );
    return MaterialApp(
      title: 'UI Designs',
      debugShowCheckedModeBanner: false,
      initialRoute: 'scroll',
      routes: {
        'basic' : (BuildContext context ) => BasicPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'blur'  : (BuildContext context ) => BlurPage(),
      },

    );
  }
}