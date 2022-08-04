import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseAPIToken = '';

  final _storage = const FlutterSecureStorage();

  Future<String?> createUser(
      {required String email, required String password}) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseAPIToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    log(decodeResp.toString());

    if (decodeResp.containsKey('idToken')) {
      await _storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'] ?? 'Error en el registro';
    }
  }

  Future<String?> login(
      {required String email, required String password}) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword',
        {'key': _firebaseAPIToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    log(decodeResp.toString());

    if (decodeResp.containsKey('idToken')) {
      await _storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return 'Error en el login';
    }
  }

  Future<bool> logout() async {
    await _storage.delete(key: 'token');
    return true;
  }

  Future<String> readToken() async {
    return await _storage.read(key: 'token') ?? '';
  }
}
