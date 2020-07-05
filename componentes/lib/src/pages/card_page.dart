import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards')
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          SizedBox(height: 30.0,),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          SizedBox(height: 30.0,),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          SizedBox(height: 30.0,),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          SizedBox(height: 30.0,),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue[300]),
            title: Text('Lorem ipsum dolor sit amet'),
            subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus libero odio, condimentum sit amet eros ut, dapibus convallis purus.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('CANCELAR'), 
                textColor: Colors.red[300],
                onPressed: () {},
              ),
              FlatButton(
                child: Text('OK'), 
                textColor: Colors.blue[300],
                onPressed: () {},
              ),
            ],
          )
        ]
      )
    );
  }


  Widget _cardTipo2() {
    return Card(
      clipBehavior: Clip.antiAlias, // hace que la imagen no se salga
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget> [
          FadeInImage(
            image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/a/a0/Palacio_de_Cristal%2C_Retiro%2C_Madrid.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 300,
            fit: BoxFit.cover
          ),

          // Image(
          //   image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/a/a0/Palacio_de_Cristal%2C_Retiro%2C_Madrid.jpg'),
          // ),
          Container(
            child: Text('Lorem ipsum dolor sit amet'),
            padding: EdgeInsets.all(10.0),
          ),
        ]
      ) ,
    );
  }

}