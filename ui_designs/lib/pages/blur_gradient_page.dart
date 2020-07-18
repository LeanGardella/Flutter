import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BlurPage extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    final _maxWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
        body: Stack(
        children: <Widget>[
          _background(context, _maxWidth * 0.85),
          SingleChildScrollView(
            child: Column(
              children: [
                _header(),
                _options(_maxWidth * 0.5),
                
              ]
            ),
          ),
          
         
        ],
      ),
      bottomNavigationBar: _footer(),
    );
  }
        
  Widget _background(context, lado) {

    final gradienteFondo = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54,  101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ]
        )
      ),
    );

    

    final overlapBox = Positioned(
      top: lado * -0.25,
      child: Transform.rotate(
        angle: -pi/4.5,
        child: _getBox(lado),
      ),
    );
      
      
    return Stack(
      children: <Widget>[
        gradienteFondo,
        overlapBox,
      ],
    );
  }

  Widget _getBox(lado) {
    return Container(
      height: lado,
      width: lado,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(235, 77, 198, 1.0),
            Color.fromRGBO(240, 134, 164, 1.0),
          ]
        ),
      ),
    );
  }

  Widget _footer() {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(58, 53, 89, 1.0),
      unselectedItemColor: Color.fromRGBO(111, 106, 150, 1.0),
      selectedItemColor: Colors.pinkAccent,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _gradientIcon(Icon(Icons.calendar_today)),
          title: Container()
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          title: Container()
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account),
          title: Container()
        ),
      ],

    );
  }

  Widget _gradientIcon(Icon child) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: FractionalOffset(0.8, 0.3),
        end: FractionalOffset(0.2, 0.4),
        colors: [
          Color.fromRGBO(235, 77, 198, 1.0),
          // Colors.blue
          Color.fromRGBO(240, 134, 164, 1.0),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }

  Widget _header() {
    return SafeArea(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('App con blur', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0),
              Text('Soy una app con blur en sus botoncitos...',style: TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic),)
            ],
          ),
      ),
    );
  }

  Widget _options(double lado) {
    return Padding(
      padding:  EdgeInsets.all(lado * 0.1),
      child: Table(
        children: [
         
        TableRow(
          children: [
            _getOption(lado, Colors.blue, Icons.border_all, 'General' ),
            _getOption(lado, Colors.purpleAccent, Icons.directions_bus, 'Bus' ),
          ]
        ),
        TableRow(
          children: [
            _getOption(lado, Colors.pinkAccent, Icons.shop, 'Buy' ),
            _getOption(lado, Colors.orange, Icons.insert_drive_file, 'File' ),
          ]
        ),
        TableRow(
          children: [
            _getOption(lado, Colors.blueAccent, Icons.movie_filter, 'Entertaiment' ),
            _getOption(lado, Colors.green, Icons.cloud, 'Grocery' ),
          ]
        ),
        TableRow(
          children: [
            _getOption(lado, Colors.red, Icons.collections, 'Photos' ),
            _getOption(lado, Colors.teal, Icons.help_outline, 'General' ),
          ]
        )
        
          
        ],
      ),
    );
  }

  Widget _getOption(lado, color, icon, text) {
    return Container(
      margin: EdgeInsets.all(lado * 0.10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(lado * 0.15),
        
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            
            height: lado * 0.7,
            width: lado * 0.7,
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 67, 107, 0.7),  
              borderRadius: BorderRadius.circular(lado * 0.15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: lado * 0.15,
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white, size: lado * 0.15,),
                ),
                SizedBox(height: lado * 0.05,),
                Text('$text', style: TextStyle(color: color, fontSize: lado * 0.08),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}