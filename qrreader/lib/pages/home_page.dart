

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qrreader/bloc/scans_bloc.dart';
import 'package:qrreader/models/scan_model.dart';

import 'package:qrreader/utils/utils.dart' as utils;


import 'package:qrreader/pages/map_page.dart';
import 'package:qrreader/pages/url_page.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int _currentIdx = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              scansBloc.deleteAll();
            },
          )
        ],
        title: Text('QR Scanner'),
      ),

      body: _callPage(_currentIdx),

      bottomNavigationBar: _bottomNavBar(),

      floatingActionButton: _floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIdx,
      onTap: (idx) {
        setState(() {
          _currentIdx = idx;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        ),
      ],
    );
  }

  Widget _callPage(int opt) {
    switch ( opt ){
      case 0:
        return MapPage();

      case 1:
        return UrlPage();

      default: 
        return MapPage(); 
    }

  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: _scanQr,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _scanQr() async {
    // https://www.fernando-herrera.com
    // geo:40.742081,-74.004480

    String futureString = '';
    futureString = 'https://www.fernando-herrera.com';


    // try{
    //   futureString = await scanner.scan();
    // }catch(e) {
    //   futureString = e.toString();
    // }

    if(futureString != null ){
      // hay datos
      final Scan scan = Scan(value: futureString);
      scansBloc.addScan(scan);
      final Scan scan2 = Scan(value: 'geo:40.742081,-74.004480');
      scansBloc.addScan(scan2);


      if(Platform.isIOS){ // Soluciona un problema de animación en iOS
        Future.delayed(Duration(milliseconds: 700), () {
          utils.abrirScan(context, scan);

        });
      }else
        utils.abrirScan(context , scan);

    } else {
      // no hay datos
    }

  }
}