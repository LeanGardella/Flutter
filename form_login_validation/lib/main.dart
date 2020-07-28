import 'package:flutter/material.dart';
import 'package:form_login_validation/src/bloc/provider.dart';
import 'package:form_login_validation/src/pages/home_page.dart';
import 'package:form_login_validation/src/pages/login_page.dart';
import 'package:form_login_validation/src/pages/product_page.dart';
import 'package:form_login_validation/src/pages/register_page.dart';
import 'package:form_login_validation/src/utils/user_prefs_util.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPreferences();
  return runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final theme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(90, 70, 178, 1.0),
    accentColor: Color.fromRGBO(63, 133, 156, 1.0),
            
    // Define the default font family.
    // fontFamily: 'Georgia',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline4: TextStyle(fontSize: 36.0, color: Colors.white),
      headline6: TextStyle(fontSize: 24.0 ),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'home' : (BuildContext context) => HomePage(),
          'product' : (BuildContext context) => ProductPage(),
        },
        theme: theme,
      ),
    );
    

  }
}