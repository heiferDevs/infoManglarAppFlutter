import '../constants.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html';

import 'fileExport.dart';

class FilePickerApp {
  static Future<FileExport> getImagePath() async {
    return await getFile(['.jpg', '.png', '.jpeg']);
  }

  static Future<FileExport> getImageOrDocumentPath() async {
    return await getFile([
      '.jpg',
      '.png',
      '.jpeg',
      '.pdf',
      '.doc',
      '.docx',
      '.xls',
      '.xlsx',
      '.csv'
    ]);
  }

  static Future<FileExport> getGeoJsonPath() async {
    return await getFile(['.geojson']);
  }

  static Future<FileExport> getFile(List<String> exts) async {
    if (Constants.isWeb) {
      return await getFileWeb(exts);
    }
    return await getFileMovil(exts);
  }

  static Future<FileExport> getFileWeb(List<String> exts) async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();
    await for (Event event in uploadInput.onChange) {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        String nameFile = file.name;
        if (!hasExtensions(nameFile, exts)) {
          return null;
        }
        final reader = new FileReader();
        reader.readAsDataUrl(file);
        await for (ProgressEvent progressEvent in reader.onLoadEnd) {
          String base64 = reader.result;
          return FileExport(
              name: nameFile, type: getType(nameFile), base64: base64);
        }
      }
    }
    return null;
  }

  static Future<FileExport> getFileMovil(List<String> exts) async {
    String filePath = await FilePicker.getFilePath(type: FileType.ANY);
    String nameFile = filePath != null ? filePath.split('/').last : 'no-name';
    if (hasExtensions(nameFile, exts)) {
      return FileExport(
          name: nameFile, type: getType(nameFile), path: filePath);
    }
    return null;
  }

  static bool hasExtensions(String n, List<String> exts) {
    String name = n.toLowerCase();
    for (String ext in exts) {
      if (name.toLowerCase().contains(ext)) {
        return true;
      }
    }
    return false;
  }

  static String getType(String n) {
    String name = n.toLowerCase();
    if (name.contains('.mp4')) return 'video';
    if (name.contains('.jpg') ||
        name.contains('.png') ||
        name.contains('.jpeg')) return 'photo';
    if (name.contains('.doc') ||
        name.contains('.docx') ||
        name.contains('.pdf') ||
        name.contains('.xls') ||
        name.contains('.xlsx') ||
        name.contains('.csv')) return 'document';
    if (name.contains('.geojson')) return 'geojson';
    return 'no_type';
  }

  static String getUrl(String type, String name) {
    switch (type) {
      case 'video':
        return '${Constants.hostUrl}rest/file/videos/$name';
      case 'photo':
        return '${Constants.hostUrl}rest/file/images/$name';
      case 'document':
        return '${Constants.hostUrl}rest/file/documents/$name';
      case 'geojson':
        return '${Constants.hostUrl}rest/file/geojsons/$name';
      default:
        throw 'ADD TYPE $type TO GET URL';
    }
  }
}
