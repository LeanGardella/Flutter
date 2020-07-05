import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('Alert Page')),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar Alerta'),
          color: Colors.blue,
          textColor: Colors.white,
          shape: StadiumBorder(),
          onPressed: (){_mostrarAlerta(context);},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_backspace),
      ),
    );
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context ) {
        return AlertDialog(
          title: Text('Tìtulo'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Contenido de la alerta que quiero mostrar para hacer algo o notificar algo'),
              SizedBox(height: 30,),
              FlutterLogo(size: 100),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('CANCELAR')
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('OK')
            ),
          ],
        );
      }
    );
  }
}