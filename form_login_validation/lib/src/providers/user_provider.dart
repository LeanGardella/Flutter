import 'dart:convert';

import 'package:form_login_validation/src/utils/user_prefs_util.dart';
import 'package:http/http.dart' as http;

class UserProvider {

  final _API_KEY = 'AIzaSyDGsLAKGPnuZVRJYFR-qeqEnibaFpNr9Bc';
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login( String mail , String pass ) async {
    final auth = {
      'email' : mail,
      'password': pass,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_API_KEY',
      body: json.encode(auth)
    );

    final Map<String, dynamic> decoded = json.decode(resp.body);

    print(decoded);

    if(decoded.containsKey('idToken')){
      _prefs.token = decoded['idToken'];
      return {'ok' : true, 'token': decoded['idToken']};
    } else {
      return {'ok': false, 'message': decoded['error']['message']};
    }
  }

  Future<Map<String, dynamic>> register( String mail , String pass ) async {
    final auth = {
      'email' : mail,
      'password': pass,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_API_KEY',
      body: json.encode(auth)
    );

    final Map<String, dynamic> decoded = json.decode(resp.body);

    print(decoded);

    if(decoded.containsKey('idToken')){
      _prefs.token = decoded['idToken'];
      return {'ok' : true, 'token': decoded['idToken']};
    } else {
      return {'ok': false, 'message': decoded['error']['message']};
    }
  } 
}