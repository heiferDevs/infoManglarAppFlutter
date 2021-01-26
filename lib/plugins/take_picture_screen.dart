import 'dart:async';
import '../util/utility.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final Function onSave;
  const TakePictureScreen({
    Key key,
    @required this.onSave,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    takePicture().then((CameraDescription camera){
      // To display the current output from the Camera,
      // create a CameraController.
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        camera,
        // Define the resolution to use.
        ResolutionPreset.medium,
      );

      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _controller.initialize();
      setState(() {
        _loaded = true;
      });
    });
  }

  Future<CameraDescription> takePicture() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    return cameras.first;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loaded
        ? _cameraScaffold()
        : new Center(child: new CircularProgressIndicator(),);
  }

  _cameraScaffold(){
    return Scaffold(
      appBar: AppBar(title: Text('Cámara')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Utility.getCircularProgress();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            final String nameFile = '${DateTime.now()}.png';
            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              nameFile,
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            Navigator.pop(context);

            widget.onSave(nameFile, path);

          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }

}
