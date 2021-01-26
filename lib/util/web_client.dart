import 'dart:convert';
import './user.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class WebClient {
  final hostUrl = Constants.hostUrl;

  Future<dynamic> get(String url) async {
    print('get $url');
    http.Response response;
    try {
      response = await http.get(
        '$hostUrl$url',
        headers: _headers(),
      );
    } catch (e) {
      String error = 'ERROR: No hay conexión con el servidor';
      return {'value': error, 'state': error};
    }

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    String r = utf8.decode(response.bodyBytes);
    return json.decode(r);
  }

  Future<dynamic> post(String url, dynamic data) async {
    print('post $hostUrl $url $data');
    http.Response response;
    try {
      response = await http.post(
        '$hostUrl$url',
        body: data,
        headers: _headers(),
      );
    } catch (e) {
      String error = 'ERROR: No hay conexión con el servidor';
      return {'value': error, 'state': error};
    }

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    try {
      String r = utf8.decode(response.bodyBytes);
      return json.decode(r);
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }

  Future<dynamic> put(String url, dynamic data) async {
    print('put $data');
    http.Response response;
    try {
      response = await http.put(
        '$hostUrl$url',
        body: data,
        headers: _headers(),
      );
    } catch (e) {
      String error = 'ERROR: No hay conexión con el servidor';
      return {'value': error, 'state': error};
    }

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    try {
      String r = utf8.decode(response.bodyBytes);
      return json.decode(r);
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }

  _headers() {
    if (User.userPin != null && User.pass != null) {
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('${User.userPin}:${User.pass}'));
      return {
        'Content-Type': 'application/json; encoding=utf-8; charset=utf-8',
        'Accept': 'application/json; encoding=utf-8; charset=utf-8',
        'Authorization': basicAuth,
      };
    }
    return {
      'Content-Type': 'application/json; encoding=utf-8; charset=utf-8',
      'Accept': 'application/json; encoding=utf-8; charset=utf-8',
    };
  }
}
