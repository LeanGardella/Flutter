
import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState () =>_ContadorPageState();

}

class _ContadorPageState extends State {

  int _conteo = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de taps:', style: TextStyle(fontSize: 25),),
            Text('$_conteo', style: TextStyle(fontSize: 60),),
          ],
        )),
      floatingActionButton: crearBotones() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
  }

  Row crearBotones () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget> [
        SizedBox(width: 30.0),
        FloatingActionButton( child: Icon(Icons.replay), onPressed: () { _calcular(0); } ),
        Expanded(child: SizedBox()),
        FloatingActionButton( child: Icon(Icons.add), onPressed: () { _calcular(1); } ),
        SizedBox(width: 5.0,),
        FloatingActionButton( child: Icon(Icons.remove), onPressed: () { _calcular(-1); } )
    ]);
  }

  void _calcular (int v){

    switch (v) {
      case 0: 
        _conteo = 0;
        break;
      case 1: 
        _conteo++;
        break;
      case -1: 
        _conteo--;
        break;
      default:
        break;
    }
    setState(() {});
  }

}


 

