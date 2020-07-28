import 'package:flutter/material.dart';
import 'package:form_login_validation/src/bloc/provider.dart';
import 'package:form_login_validation/src/models/product_model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productoBloc(context);

    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio')
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'product').then((value) => setState((){})),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearListado(ProductBloc b) {
    return StreamBuilder(
      stream: b.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
    
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (dir) {
                  b.eliminarProducto(snapshot.data[i]);
                  setState(() {});
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      (snapshot.data[i].fotoUrl == null) ? 
                      Image(image : AssetImage('assets/noimg.png') ) :
                      FadeInImage(
                        placeholder: AssetImage('assets/progress-circle.gif'), 
                        image: NetworkImage(snapshot.data[i].fotoUrl),
                        height: 300.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      ListTile(
                        title: Text(snapshot.data[i].titulo),
                        subtitle: Text(snapshot.data[i].valor.toString()),
                        leading: Icon(Icons.add_shopping_cart),
                        onTap: () => Navigator.pushNamed(context, 'product', arguments: snapshot.data[i]).then((value) => setState((){})),
                      ),
                    ],
                  ),
                ),
                
                
              );
            }
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}