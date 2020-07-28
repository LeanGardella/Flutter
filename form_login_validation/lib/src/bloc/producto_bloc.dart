import 'dart:io';

import 'package:form_login_validation/src/providers/productos_provider.dart';
import 'package:rxdart/subjects.dart';

import 'package:form_login_validation/src/models/product_model.dart';

class ProductBloc {

  final _productCtrl = new BehaviorSubject<List<ProductoModel>>();
  final _loadingCtrl = new BehaviorSubject<bool>();

  final _prodsProv = new ProductosProvider();

  Stream<List<ProductoModel>> get productosStream => _productCtrl.stream;
  Stream<bool> get loadingStream => _loadingCtrl.stream;

  void cargarProductos() async {
    _loadingCtrl.sink.add(true);
    final productos = await _prodsProv.cargarProductos();
    _productCtrl.sink.add(productos);
    _loadingCtrl.sink.add(false);
  }

  void agregarProducto(ProductoModel p) async {
    _loadingCtrl.sink.add(true);
    await _prodsProv.crearProducto(p);
    _loadingCtrl.sink.add(false);
  }

  Future<String> subirFoto(File f) async {
    _loadingCtrl.sink.add(true);
    final fotoUrl = await _prodsProv.subirFoto(f);
    _loadingCtrl.sink.add(false);
    return fotoUrl;
  }

  void modificarProducto(ProductoModel p) async {
    _loadingCtrl.sink.add(true);
    await _prodsProv.modificarProducto(p);
    _loadingCtrl.sink.add(false);
  }

  void eliminarProducto( ProductoModel p ) async {
    await _prodsProv.eliminarProducto(p);
  }

  dispose() {
    _productCtrl?.close();
    _loadingCtrl?.close();
  }
}