import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:user_preferences_app/src/pages/home_page.dart';
import 'package:user_preferences_app/src/pages/settings_page.dart';
import 'package:user_preferences_app/src/shared_prefs/user_prefs_util.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await new UserPreferences().initPreferences();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.ultimaPagina ?? HomePage.routeName,
      routes: {
        HomePage.routeName : (BuildContext context) => HomePage(),
        SettingsPage.routeName : (BuildContext context) => SettingsPage(),
      },
    );
  }
}