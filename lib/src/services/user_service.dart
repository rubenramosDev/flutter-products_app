import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:productsapp/src/preferences/preferencias_usuario.dart';

class UserService {
  final String _firebaseToken = 'AIzaSyBLBbpNX1RBHhMzabz-cVlvgGAuG4-mhi8';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final _authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(_authData));

    Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      _prefs.token = decodeResponse['idToken'];
      return {'ok': true, 'token': decodeResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodeResponse['error']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    print(email);
    final _authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(_authData));

    Map<String, dynamic> decodeResponse = json.decode(response.body);
    print(decodeResponse);
    print('hey');
    if (decodeResponse.containsKey('idToken')) {
      //Saving the token on the sharedPreferences
      _prefs.token = decodeResponse['idToken'];
      return {'ok': true, 'token': decodeResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodeResponse['error']['message']};
    }
  }
}
