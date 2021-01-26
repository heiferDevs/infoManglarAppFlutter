import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Upload {

  static Future<String> uploadFile(File imageFile, String uploadURL, String nameFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(uploadURL);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(nameFile));
    var multipartData = new http.MultipartFile.fromString('name', nameFile);
    request.files.add(multipartFile);
    request.files.add(multipartData);

    var response = await request.send();
    var respStr = await response.stream.toBytes();

    String responseString = utf8.decode(respStr);

    try{
      String state = json.decode(responseString)['state'];
      return state;
    } catch(e) {
      print('Error: no json $responseString');
    }
    return 'Error no result $responseString';
  }

  static Future<String> uploadFileFromBase64Str(String source, String uploadURL, String nameFile) async {
    Uint8List bytes = base64.decode(source);
    var uri = Uri.parse(uploadURL);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = MultipartFile.fromBytes('file', bytes);
    var multipartData = new http.MultipartFile.fromString('name', nameFile);
    request.files.add(multipartFile);
    request.files.add(multipartData);

    var response = await request.send();
    var respStr = await response.stream.toBytes();

    String responseString = utf8.decode(respStr);
    try{
      String state = json.decode(responseString)['state'];
      return state;
    } catch(e) {
      print('Error: no json $responseString');
    }
    return 'Error no result $responseString';
  }

}
