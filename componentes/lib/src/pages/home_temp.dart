import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {

  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco', 'Seis', 'Siete', 'Ocho', 'Nueve', 'Diez','Once', 'Doce', 'Trece', 'Catorce', 'Quince'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: Text('Componentes')),
        body: ListView(
          // children: _crearItems()
          children: _crearItemsCorto()
        )
      )
    );
  }

  List<Widget> _crearItems() {

    List<Widget> lista = new List<Widget>();
    for (String opt in opciones) {
      // lista.add(ListTile(title: Text(opt)));
      // lista.add(Divider());

      lista..add(ListTile(title: Text(opt)))
           ..add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorto() {
    return opciones.map( (item ) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: Text('Cualquier cosa'),
            leading: Icon(Icons.add_alert),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              
            },
            ),
          Divider()
        ],
      );
    }).toList();

  }
}