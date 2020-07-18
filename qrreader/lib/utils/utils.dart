
import 'package:qrreader/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context, Scan s) async {
  if(s.type == 'http'){

    if (await canLaunch(s.value)) {
      await launch(s.value);
    } else {
      throw 'Could not launch ${s.value}';
    }
  }else {
    Navigator.pushNamed(context, 'map', arguments: s);
  }
}