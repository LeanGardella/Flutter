import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valor = 50.0;
  bool _bloquear = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slider'),),
      body: Container(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _crearCheckbox(),
            _crearSwitch(),
            SizedBox(height: 20.0,),
            Expanded(child: _crearImagen()),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: <Widget>[
        
          FloatingActionButton(
            child: Icon(Icons.zoom_out),
            onPressed: (_bloquear) ? null :  () => setState(() {
              double delta = 10.0;
              if(_valor - delta < 0) {
                delta = _valor;
              }
              _valor = _valor - delta;
            }),
            heroTag: 'out',
            
          ),
          SizedBox(width: 10.0,),
          FloatingActionButton(
            child: Icon(Icons.zoom_in),
            onPressed: (_bloquear) ? null : () => setState(() {
              double delta = 10.0;
              if(_valor + delta > 100) {
                delta = 100 - _valor;
              }
              _valor = _valor + delta;
            }),
            heroTag: 'in',
          ),

        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  Widget _crearCheckbox() {
    return CheckboxListTile(
      title: Text('Bloquear tamaño de imagen'),
      value: _bloquear, 
      onChanged: (value) {
        setState(() {
          _bloquear = value;
        });
      }
    );
  }
  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear tamaño de imagen'),
      value: _bloquear, 
      onChanged: (value) {
        setState(() {
          _bloquear = value;
        });
      }
    );
  }

  Widget _crearImagen () {
    return Image(
      image: NetworkImage('https://i.pinimg.com/originals/40/fa/1e/40fa1e16c8b4a673b4ccddce66dfe33e.png'),
      width: _valor*4,
      fit: BoxFit.fitWidth
    );
  }

  Widget _crearSlider() {
    return Slider(
      label: 'Tamaño de la imagen',
      // divisions: 20,
      activeColor: Colors.indigoAccent,
      onChanged: (_bloquear) ? null : (double value) {  
        setState(() {
          _valor = value;
        });
      }, 
      value: _valor,
      min: 0.0,
      max: 100.0
    );

  }
}