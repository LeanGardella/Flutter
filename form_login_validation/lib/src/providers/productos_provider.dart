import 'dart:convert';

import 'dart:io';

import 'package:form_login_validation/src/utils/user_prefs_util.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:form_login_validation/src/models/product_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-38716.firebaseio.com';
  final _prefs = new UserPreferences();

  Future<bool> crearProducto( ProductoModel p ) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    await http.post(url, body: productoModelToJson(p));
    return true;
  }

  Future<List<ProductoModel>>cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final Map<String, dynamic> decoded = json.decode(resp.body);
    if(decoded == null) return [];

    final List<ProductoModel> productos = new List();
    decoded.forEach((id, prod) {
      final temp = ProductoModel.fromJson(prod);
      temp.id = id;
      productos.add(temp);
    });
    return productos;
  }

  Future<int> eliminarProducto(ProductoModel p) async {
    final url = '$_url/productos/${p.id}.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print(resp);
    return 1;
  }

  Future<bool> modificarProducto( ProductoModel p ) async {
    final url = '$_url/productos/${p.id}.json?auth=${_prefs.token}';
    await http.put(url, body: productoModelToJson(p));
    return true;
  }

  Future<String> subirFoto(File f) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/leangarde/image/upload?upload_preset=urbyxfuk');
    final mimeType = mime(f.path).split('/');

    final request = http.MultipartRequest(
      'POST',
      url
    );
    final file = await http.MultipartFile.fromPath(
      'file', 
      f.path, 
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    request.files.add(file);

    final streamResponse = await request.send();
    final respuesta = await http.Response.fromStream(streamResponse);

    if( respuesta.statusCode != 200 && respuesta.statusCode != 201 ){
      print('fallò la subida');
      print(respuesta.body);
      return null;
    } else {
      final respdata = json.decode(respuesta.body);
      print('Provider - respData = ${respdata['secure_url']}');
      return respdata['secure_url'];
    }
  }

}