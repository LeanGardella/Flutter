import 'dart:async';

import 'package:flutter/material.dart';

class ListviewPage extends StatefulWidget {
  @override
  _ListviewPageState createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  final _numeros = new List<int>();
  int _last = 0;

  ScrollController _controller = new ScrollController();

  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
    _agregar10();
    _controller.addListener(() {

      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        fetchData();
      
      }
    });
  }

  @override
  void dispose() {
    
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Builder'),
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _crearLoading(),
        ],
      ),
    );
  }

  _crearLista() {
    return RefreshIndicator(
      onRefresh: _restart,
      child: ListView.builder(
        controller: _controller,
        itemCount: _numeros.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _numeros[index];
          return FadeInImage(
            image: NetworkImage('https://picsum.photos/500/300/?image=$imagen') ,
            placeholder: AssetImage('assets/jar-loading.gif'),
          );
        },
      ),
    );
  }

  void _agregar10() {
    for (var i = 0; i < 5; i++) {
      _last++;
      _numeros.add(_last%80);
    }
    setState(() {});
  }

  Future<Null> fetchData() async {
    _isLoading = true;
    setState(() {});

    new Timer(new Duration(seconds: 2), respuestaHttp);
  }

  void respuestaHttp() {
    _isLoading = false;
    _agregar10();
    _controller.animateTo(
      _controller.position.pixels +100, 
      duration: Duration(milliseconds: 500), 
      curve: Curves.easeInOut
    );
  }

  Widget _crearLoading() {
    if(_isLoading) {
      return 
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(backgroundColor: Colors.white38,),
                ],
              ),
              SizedBox(height: 15.0,)
            ],
          );
        
    }else {
      return Container();
    }
  }

  Future<Null> _restart () async {
    new Timer (Duration(seconds: 3), () {
      _last++;
      _numeros.clear();
      _agregar10();
    });
    return Future.delayed(Duration(seconds: 3));
  }
}