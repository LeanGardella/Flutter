import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_login_validation/src/bloc/provider.dart';
import 'package:form_login_validation/src/models/product_model.dart';
import 'package:form_login_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductBloc pb;

  ProductoModel producto = new ProductoModel();

  bool _saving = false;

  PickedFile photo;

  @override
  Widget build(BuildContext context) {
    pb = Provider.productoBloc(context);
    ProductoModel arg = ModalRoute.of(context).settings.arguments;

    if( arg != null )  {
      producto = arg;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                SizedBox(height: 40.0,),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      textCapitalization: TextCapitalization.sentences,
      validator: (value) => (value.length < 3) ? 'Ingrese al menos 3 caracteres.' : null,
      onSaved: (newValue) => producto.titulo = newValue,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) => (utils.isNumber(value)) ? null : 'El precio debe ser numérico.',
      onSaved: (v) => producto.valor = double.parse(v),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      onPressed: (_saving == true ) ? null : submit, 
      icon: Icon(Icons.save), 
      label: Text('Guardar'),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible, 
      title: Text('Producto disponible'),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (v){
        producto.disponible = v;
        setState(() {});
        return;
      },
    );
  }

  void submit() async {
    if( ! formKey.currentState.validate() ) return;
    formKey.currentState.save();

    setState(() {
      _saving = true;
    });

    if( photo != null ) { // el usuario seleccionó foto
      
      producto.fotoUrl = await pb.subirFoto(File(photo.path));

    }
    
    if(producto.id == null) // Si el producto es nuevo, lo creo
      pb.agregarProducto(producto);
    else // Si no, lo edito
      pb.modificarProducto(producto);

    _crearMensaje('Producto guardado correctamente.');

    Navigator.pop(context);
  }

  _crearMensaje(String m) {
    final snack = new SnackBar(
      content: Text(m),
      duration: Duration(milliseconds: 1500),
    );
    //Scaffold.of(context).showSnackBar(snack);
  }

  _seleccionarFoto() async{
    _procesarFoto(ImageSource.gallery);
  }
  
  _tomarFoto() async {
    _procesarFoto(ImageSource.camera);
  }

  _procesarFoto(ImageSource s) async {
    photo = await ImagePicker().getImage(source: s);

    if( photo != null ){
      producto.fotoUrl = null;
    }

    setState(() {
      _mostrarFoto();
    });
  }

  Widget _mostrarFoto() {
    if(producto.fotoUrl != null)
      return FadeInImage(
        placeholder: AssetImage('assets/progress-circle.gif'), 
        image: NetworkImage(producto.fotoUrl),
        height: 300.0,
        fit: BoxFit.contain,
        );
    else
      return Image(
        image: (photo?.path != null) ? FileImage(File(photo.path)) : AssetImage('assets/noimg.png'),
      );
  }

}