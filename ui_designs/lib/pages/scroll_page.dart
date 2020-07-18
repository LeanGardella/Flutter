import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ui_designs/providers/weather_provider.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    WeatherProvider _weatherProv = new WeatherProvider();
    final _temp =  _weatherProv.getCurrentTemperature('Buenos Aires');

    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _crearHome(_temp),
          _crearMain(context),
        ],
      ),
    );
  }

  Widget _crearHome(temp) {
    var stack = Stack(
      children: <Widget>[
        _colorearFondo(),
        _crearImgFondo(),
        FutureBuilder(
          future: temp,
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasData) 
            { 
              return _crearOverlay(snapshot.data-273.15);
            }
            else
              return Container(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator()
                )
              );
          },
        )
        
      ],
    );
    return stack;
  }

  Widget _crearMain(context) {
    return Stack(
      children: <Widget>[
        _colorearFondo(),
        Center(
          child: RaisedButton(
            elevation: 10.0,
            color: Colors.blue,
            shape: StadiumBorder(),
            onPressed: () { 
              Navigator.pushNamed(context, 'blur');
             },
            child: Padding(padding: EdgeInsets.all(20.0),child: Text('Ingresar', style: TextStyle(color: Colors.white, fontSize: 30.0),)),
          ),
        ),
      ],
    );
  }

  Widget _crearOverlay(double temp) {
    final dia = DateTime.now();

    final map = new HashMap.from({
      1: 'Lunes',
      2: 'Martes',
      3: 'Miércoles',
      4: 'Jueves',
      5: 'Viernes',
      6: 'Sábado',
      7: 'Domingo'
    });

    return SafeArea(
          child: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 50.0,),
          Text('${temp.toStringAsFixed(1)}º', style: TextStyle(color: Colors.white, fontSize: 50.0),),
          Text('${map[dia.weekday]}', style: TextStyle(color: Colors.white, fontSize: 50.0),),
          Expanded(child: SizedBox()),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 70.0,),
        ],),
      ),
    );
  }

  Widget _colorearFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(80, 194, 221, 1.0),
    );
  }

  _crearImgFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(image: AssetImage('assets/background.png'), fit: BoxFit.cover),
    );
  }
  
}

