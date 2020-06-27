

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  int conteo = 10;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de taps:', style: TextStyle(fontSize: 25),),
            Text('$conteo', style: TextStyle(fontSize: 60),),
          ],
        )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // conteo++;
        },
      )  ,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  
}