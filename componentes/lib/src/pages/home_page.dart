import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/utils/icon_string_util.dart';
import 'package:flutter/material.dart';
import 'package:componentes/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Componentes'),),
      body: _lista()
      );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: ( context, AsyncSnapshot snapshot) {
        return ListView(
          children: _crearListaItems(snapshot.data, context),
        );      
      }
    );
  }

  List<Widget> _crearListaItems(List<dynamic> data, BuildContext context) {

    final List<Widget> list = [];

    data.forEach((element) {
      final widgetTemp = ListTile(
        title: Text(element['texto']),
        leading: getIcon(element['icon'], Colors.blue[300]),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue[300],),
        onTap: () {
          // final route = MaterialPageRoute(
          //   builder: (context) => AlertPage()
          // );
          // Navigator.push(context, route);

          Navigator.pushNamed(context, element['ruta']);
        },
      );
      list..add(widgetTemp)
          ..add(Divider());
    });
    return list;
  }
}