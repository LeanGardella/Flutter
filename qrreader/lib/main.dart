import 'package:flutter/material.dart';
import 'package:qrreader/pages/display_map_page.dart';
import 'package:qrreader/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context ) => HomePage(),
        'map': (BuildContext context ) => DisplayMapPage(),

      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(84, 21, 122 , 1.0),
        //backgroundColor: Colors.grey[800],
      ),
    );
  }
}