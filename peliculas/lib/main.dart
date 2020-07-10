import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/movie_detail_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      theme: _defaultTheme(), 
      debugShowCheckedModeBanner: false,
      title: 'MetFlix',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context ) => HomePage(),
        'detail': (BuildContext context ) => MovieDetails(),
      },
    );
  }

  _defaultTheme() {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,

    );
  }
}