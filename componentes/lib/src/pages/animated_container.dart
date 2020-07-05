import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  AnimatedContainerPage({Key key}) : super(key: key);

  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {

  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.pink;
  BorderRadiusGeometry _radius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
        appBar: AppBar(
           title: Text('Container animado'),
        ),
        body: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              borderRadius: _radius,
              color: _color
            ),
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_circle_outline),
          onPressed: () {
            setState(() {
              final _random = new Random();
              _width = _random.nextInt(300).toDouble();
              _height = _random.nextInt(300).toDouble();
              _color = Color.fromRGBO(
                _random.nextInt(255), 
                _random.nextInt(255), 
                _random.nextInt(255), 
                1
              );
              _radius = BorderRadius.circular(_random.nextInt(100).toDouble());
            });
          },
        ),
      ),
    );
  }
}