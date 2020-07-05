import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://userscontent2.emaze.com/images/e346dbe4-1ec2-4e13-8b8c-16e0ce7c0f3d/680d3159afe4c5f5bd830ced5b0d82df.jpg'),
              radius: 25.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('SJ'),
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: FadeInImage.assetNetwork(placeholder: 'assets/jar-loading.gif', image: 'https://hipertextual.com/archivo/wp-content/uploads/2012/08/Steve-Jobs-Macbook-Air-2008.jpg')
      ),
    );
  }
}