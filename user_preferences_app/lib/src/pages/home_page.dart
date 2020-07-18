import 'package:flutter/material.dart';
import 'package:user_preferences_app/src/shared_prefs/user_prefs_util.dart';

import 'package:user_preferences_app/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {

  static final String routeName = 'home';
  final _userPrefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    _userPrefs.ultimaPagina = HomePage.routeName;
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: (_userPrefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color secundario: ${_userPrefs.colorSecundario}'),
          Divider(),
          Text('Género: ${_userPrefs.genero}'),
          Divider(),
          Text('Nombre: ${_userPrefs.nombre}'),
          Divider(),
        ],
      ),
    );
  }

  // Drawer _crearMenu(context) {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: <Widget>[
  //         DrawerHeader(
  //           //child: Text('Mi menú'),
  //           child: Container(),
  //           decoration: BoxDecoration(
  //             image: DecorationImage(image: AssetImage('assets/img/menu.jpg'),fit: BoxFit.cover),
  //           ),
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.pages, color: Colors.blue),
  //           title: Text('Pages'),
  //           onTap: () {
  //             Navigator.pushReplacementNamed(context, HomePage.routeName);
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.party_mode, color: Colors.blue),
  //           title: Text('Photos'),
  //           onTap: () {

  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.people, color: Colors.blue),
  //           title: Text('Users'),
  //           onTap: () {

  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.settings, color: Colors.blue),
  //           title: Text('Settings'),
  //           onTap: () {
  //             // Navigator.pop(context); // Cierra el menu
  //             // Navigator.pushNamed(context, SettingsPage.routeName); // Mueve a la pagina settings

  //             Navigator.pushReplacementNamed(context, SettingsPage.routeName);
  //           },
  //         ),

  //       ],
  //     ),
  //   );
  // }
}