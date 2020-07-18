import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences_app/src/shared_prefs/user_prefs_util.dart';
import 'package:user_preferences_app/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSec = false;
  int _genero = 1;
  String _nombre = 'Jose';

  UserPreferences _up = new UserPreferences();

  TextEditingController _txtCtrl ;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    _txtCtrl = new TextEditingController( text: _nombre);
    _up.ultimaPagina = SettingsPage.routeName;
  }
  
  _loadPrefs() async {
    _genero = _up.genero;
    _colorSec = _up.colorSecundario;
    _nombre = _up.nombre;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text('Preferencias'),
        backgroundColor: (_up.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSec, 
            title: Text('Color secundario'),
            onChanged: _setSwitch
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona que usa el teléfono',
              ),
              onChanged: _setText,
              controller: _txtCtrl,
            ),
          ),
        ],
      )
    );
  }

  _setSelectedRadio(int value)  {
    _genero = value;
    setState(() {});
    _up.genero = value;
  }
  _setSwitch(bool value)  {
    _colorSec = value;
    setState(() {});
    _up.colorSecundario = value;
  }
  _setText(String value)  {
    _nombre = value;
    setState(() {});
    _up.nombre = value;
  }
}