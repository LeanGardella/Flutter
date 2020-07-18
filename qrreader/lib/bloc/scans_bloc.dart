
import 'dart:async';

import 'package:qrreader/providers/db_provider.dart';

class ScansBloc {
  static final _singleton = new ScansBloc._();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._() {
    // Obtener scans de BD
    getScans();
  }

  final _scansCtrl = new StreamController<List<Scan>>.broadcast();
  
  Stream<List<Scan>> get scansStream => _scansCtrl.stream;

  dispose(){
    _scansCtrl?.close();
  }

  // Events

  addScan(Scan s) async {
    await DBProvider.db.insertScan(s);
    getScans();
  }
  
  getScans() async {
    _scansCtrl.sink.add(await DBProvider.db.getScans());
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScanById(id);
    getScans();
  }

  deleteAll() async {
    await DBProvider.db.deleteAll();
    //getScans();
    _scansCtrl.sink.add([]);

  }

}