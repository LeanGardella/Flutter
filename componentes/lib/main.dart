
import 'package:componentes/src/pages/alert_page.dart';

import 'package:componentes/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
          const Locale('en', 'US'), // English, USA
          const Locale('es', 'ES'), // Español, España
          
      ],

      title: 'Material App',
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      initialRoute: '/',
      routes: getAppRoutes(),
      onGenerateRoute: (settings ) {
        print('Ruta llamada ${settings.name}');
        return MaterialPageRoute(
          builder: (BuildContext context ) => AlertPage()
        );
      },
    );
  }
}