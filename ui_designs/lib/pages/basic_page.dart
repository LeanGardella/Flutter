import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _getImage(),
            _getTitle(context),
            _getIcons(),
            _getText(),
          ],
        ),
      ),
      
    );
  }

  Widget _getImage() {
    return FadeInImage(
      placeholder:AssetImage('assets/loading.gif'),
      image: NetworkImage('https://s1.1zoom.me/big0/876/Spain_Evening_Houses_Madrid_Street_From_above_561574_1280x802.jpg'),
      fit: BoxFit.cover,
      height: 300.0,
    );
  }

  Widget _getTitle(context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Edificio Metrópolis', style: Theme.of(context).textTheme.headline6,),
                Text('Madrid, España', style: Theme.of(context).textTheme.subtitle1,),
              ],
            ),
          ),
          //Expanded(child: SizedBox()),
          Icon(Icons.star, color: Colors.red, size: 30.0,),
          Text('4.7'),
        ],
      ),
    );
  }

  Widget _getIcons() {
    return Container(
      padding: EdgeInsets.symmetric( vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _crearActionButton(Icons.call, 'Llamar'),
          //Expanded(child: SizedBox(),),
          _crearActionButton(Icons.near_me, 'Navegar'),
          //Expanded(child: SizedBox(),),
          _crearActionButton(Icons.share, 'Compartir'),
        ],
      ),
    );
  }

  Widget _getText() {
    final text = Text(_getLorem(), textAlign: TextAlign.justify,);

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical:10.0),
        child: text,
      ),
    );
  }

  String _getLorem() {
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sit amet fermentum ex. Vivamus eget bibendum dolor, sit amet tincidunt augue. Vivamus mattis hendrerit dui. Curabitur eleifend massa sit amet purus suscipit, ac facilisis felis volutpat. Fusce aliquet, elit at ultricies fermentum, ligula eros viverra risus, vel molestie odio turpis id odio. Nam dapibus semper tempor. Curabitur tincidunt mi eu dictum aliquam.\n\nSed placerat lorem quis tempus maximus. Aliquam erat volutpat. Sed feugiat ante in tortor venenatis, non volutpat lorem tincidunt. Sed sed turpis quis massa mollis ultricies. Nam maximus ullamcorper mollis. Aenean massa metus, semper sed pellentesque sed, molestie ut ligula. Sed rutrum ipsum eget diam efficitur, et imperdiet leo varius.\n\nSed dignissim accumsan dui, a feugiat enim condimentum sed. Vivamus eget sem viverra, posuere metus et, tristique ligula. Sed sodales tortor placerat nisi auctor euismod. Aenean dictum, mauris in porttitor posuere, neque leo elementum ex, sit amet vulputate quam nunc at est. Sed mi libero, elementum eu odio non, faucibus laoreet velit. In feugiat ligula a lectus volutpat euismod. Vestibulum vel magna a eros hendrerit rhoncus. Pellentesque nibh quam, aliquam vel lacus vitae, auctor commodo velit. Etiam ultricies eget risus sed tempor. Nullam egestas magna quis purus ultricies, vel tincidunt neque efficitur. In sagittis commodo tincidunt. Ut cursus, libero non faucibus pulvinar, enim diam semper lorem, in fringilla tortor nulla ut enim.\n\nNunc vehicula varius elementum. Ut consectetur ullamcorper consectetur. Nulla non pellentesque metus. Phasellus vel lectus ut elit maximus pulvinar. Mauris feugiat lacus cursus ex venenatis mattis. Ut ut odio feugiat mi fringilla ultrices ac a sem. Duis mollis, eros eget feugiat porttitor, urna nulla convallis ex, viverra laoreet sapien diam sit amet eros. Fusce vel ligula id orci consectetur lacinia et sed massa. Etiam non justo faucibus, gravida lectus vitae, accumsan erat.\n\nDonec quis orci rhoncus, feugiat elit in, elementum arcu. Cras mattis malesuada velit, sed volutpat nibh imperdiet ac. Integer eu ante venenatis, mollis urna et, luctus sapien. Cras volutpat dui ex, vel ultricies nisl porta et. Vivamus sed feugiat sem. Fusce elementum consequat turpis sed ornare. In eleifend felis lacus, nec finibus nulla egestas vitae. Nulla id eleifend dui. Nullam scelerisque aliquet risus, in consectetur metus vestibulum non. Vivamus convallis semper ex at eleifend. Nam cursus, ante in porttitor venenatis, metus neque fermentum urna, faucibus rhoncus nunc lacus ac erat. Donec ut vulputate orci, ac pulvinar lacus. Donec cursus, velit ut placerat tincidunt, odio eros pulvinar diam, a imperdiet est dolor eget arcu.';
   // return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sit amet fermentum ex. Vivamus eget bibendum dolor, sit amet tincidunt augue. Vivamus mattis hendrerit dui. Curabitur eleifend massa sit amet purus suscipit, ac facilisis felis volutpat. Fusce aliquet, elit at ultricies fermentum, ligula eros viverra risus, vel molestie odio turpis id odio. Nam dapibus semper tempor. Curabitur tincidunt mi eu dictum aliquam.\n\nSed placerat lorem quis tempus maximus. Aliquam erat volutpat. Sed feugiat ante in tortor venenatis, non volutpat lorem tincidunt. Sed sed turpis quis massa mollis ultricies. Nam maximus ullamcorper mollis. Aenean massa metus, semper sed pellentesque sed, molestie ut ligula.';
  }

  _crearActionButton(IconData iconData, String text) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Column(
        children: <Widget>[
          Icon(iconData, color: Colors.blue, size: 40.0,),
          SizedBox(height: 5.0,),
          Text(text, style: TextStyle(color: Colors.blue),),
        ],
      ),
    );
  }
}