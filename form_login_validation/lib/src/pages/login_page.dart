import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_login_validation/src/bloc/provider.dart';
import 'package:form_login_validation/src/providers/user_provider.dart';
import 'package:form_login_validation/src/utils/utils.dart';

class LoginPage extends StatelessWidget {

  final _usrPrv = new UserProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( // Statusbar blanco :)
     SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent,)
   );


    final _bloc = Provider.of(context);
  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _getFondo(context),
          _getLogin(context, _bloc),
        ],
      )
    );
  }

  Widget _getFondo(BuildContext context) {
    final MAX_HEIGHT = MediaQuery.of(context).size.height;
    final MAX_WIDTH = MediaQuery.of(context).size.width;

    final fondo = Container(
      width: double.infinity,
      height: MAX_HEIGHT * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 133, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        )
      ),
    );

    final burbuja = Container(
      width: MAX_WIDTH * 0.25,
      height: MAX_WIDTH * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MAX_WIDTH * 0.2),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    final titulo = Container(
      padding: EdgeInsets.only(top: MAX_HEIGHT * 0.1),
      width: double.infinity,
      height: MAX_HEIGHT * 0.4,
      child: Column(
        children: <Widget>[
          Icon(Icons.person_pin_circle, color: Colors.white, size: MAX_WIDTH *0.25),
          Text('Leandro Gardella', style: Theme.of(context).textTheme.headline4,)
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Positioned(child: burbuja, top: MAX_HEIGHT * 0.10, left: MAX_WIDTH * 0.1,),
        Positioned(child: burbuja, top: MAX_HEIGHT * -0.02, left: MAX_WIDTH * 0.80,),
        Positioned(child: burbuja, top: MAX_HEIGHT * 0.25, left: MAX_WIDTH * 0.65,),
        titulo
      ],
    );
  }

  Widget _getLogin(BuildContext context, LoginBloc b) {
    final MAX_HEIGHT = MediaQuery.of(context).size.height;
    final MAX_WIDTH = MediaQuery.of(context).size.width;

    return SingleChildScrollView(   
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MAX_HEIGHT * 0.33,
            width: double.infinity,
          ),
          Container(
            width: MAX_WIDTH * 0.85,
            padding: EdgeInsets.symmetric(vertical: MAX_HEIGHT * 0.04),
            margin: EdgeInsets.symmetric(vertical: MAX_HEIGHT * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text('Bienvenido', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: MAX_HEIGHT * 0.025,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MAX_HEIGHT * 0.005),
                  child: _email(MAX_WIDTH, b),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MAX_HEIGHT * 0.005),
                  child: _password(MAX_WIDTH, b),
                ),
                SizedBox(height: MAX_HEIGHT * 0.025,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MAX_HEIGHT * 0.015),
                  child: _button(MAX_WIDTH, MAX_HEIGHT, context, b),
                ),
              ],
            ),
          ),
          SizedBox(height: MAX_HEIGHT * 0.025,),
          FlatButton(
            child: Text('¿Eres nuevo aquí? Crear cuenta', style: TextStyle(color: Colors.deepPurple, fontStyle: FontStyle.italic, decoration: TextDecoration.underline,),),
            onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
          ),
          SizedBox(height: MAX_HEIGHT * 0.1,),
        ],
      ),
    );
  }

  Widget _email(double w, LoginBloc b) {
    return StreamBuilder(
      stream: b.mailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: w * 0.07 ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              hintText: 'nombre@dominio.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.hasData ? snapshot.data : '',
              errorText: snapshot.hasError ? snapshot.error : null,
            ),
            onChanged: b.changeMail,
          ),
        );
      },
    );
  }

  Widget _password(double w, LoginBloc b) {
    return StreamBuilder(
      stream: b.passStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: w * 0.07 ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
              labelText: 'Contraseña',
              counterText: snapshot.data == '' ? 'Vacío' : snapshot.data,
              errorText: snapshot.hasError ? snapshot.error : null,
            ),
            onChanged: b.changePass,
            
          ),
        );
      },
    );
  }
  Widget _button(double w, double h, BuildContext context , LoginBloc b ){
    return StreamBuilder(
      stream: b.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
          
            padding: EdgeInsets.symmetric(vertical: h * 0.02 , horizontal: w * 0.2 ),
            child: Text('Ingresar', style: TextStyle(color: Colors.white),),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0 ,
          color: Theme.of(context).primaryColor,
          onPressed: snapshot.hasData ? () => _login(context, b) : null,
        );
      },
    );
  }

  _login(BuildContext context , LoginBloc b) async {

    final Map<String,dynamic> info = await _usrPrv.login(b.email, b.password);

    if(info['ok']){
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showError(context, info['message'], 'Algo salió mal...');
    }
  }

}