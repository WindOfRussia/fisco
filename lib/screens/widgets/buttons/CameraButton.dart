import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  CameraButton();

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.camera_alt),
          onPressed: () => _optionsDialogBox(context)
          );
  }

  Future<void> openCamera(context) async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(image: picture),
              ),
            );
  }
  Future<void> openGallery() async {
    var gallery = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
  }

  Future<void> _optionsDialogBox(context) {
  return showDialog(context: context,
    builder: (BuildContext context) {
        return AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                GestureDetector(
                  child: new Text('Take a picture'),
                  onTap: () => {
                    openCamera(context)
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: new Text('Select from gallery'),
                  onTap: openGallery,
                ),
              ],
            ),
          ),
        );
      });
}
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final File image;

  const DisplayPictureScreen({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(image),
    );
  }
}