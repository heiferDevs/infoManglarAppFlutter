import 'package:flutter/material.dart';

class FileExport{

  String name;
  String path;
  String type;
  String base64;

  FileExport({
    @required this.name,
    @required this.type,
    this.path,
    this.base64,
  });

}
