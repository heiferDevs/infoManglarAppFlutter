import '../widgets/wrapWidget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class DisplayPicture extends StatelessWidget {

  final String imagePath;
  final String imageUrl;
  final String title;

  const DisplayPicture({
    Key key,
    this.imagePath,
    this.imageUrl,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: WrapWidget(
        child: Center(
          child: imagePath == null ? Image.network(imageUrl) : Image.file(File(imagePath)),
        )
      ),
    );
  }

}