
import 'package:flutter/material.dart';


import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:qrreader/models/scan_model.dart';

class DisplayMapPage extends StatefulWidget {
  @override
  _DisplayMapPageState createState() => _DisplayMapPageState();
}

class _DisplayMapPageState extends State<DisplayMapPage> {
  @override
  Widget build(BuildContext context) {

    final Scan scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              
            },
          )
        ],
      ),
      body: Center(
        child: _crearFlutterMap(scan),
      )
    );
  }

  Widget _crearFlutterMap(Scan scan) {
    final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(-33.852, 151.211),
    zoom: 11.0,
  );
    return MapboxMap(
      
      
      initialCameraPosition: _kInitialPosition,
    );
  }
}