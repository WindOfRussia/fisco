import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/ocr_provider.dart';

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.camera_alt),
        onPressed: () => _optionsDialogBox(context)
    );
  }

  Future<void> open(context, ImageSource source) async {
    var picture = await ImagePicker.pickImage(source: source);
    Provider.of<OcrProvider>(context, listen: false).scanImage(picture);
    Navigator.popAndPushNamed(context, '/picture', arguments: picture);
  }

  Future<void> _optionsDialogBox(context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text('Take a picture'),
                      onTap: () => open(context, ImageSource.camera)
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  GestureDetector(
                      child: Text('Select from gallery'),
                      onTap: () => open(context, ImageSource.gallery)
                  ),
                ],
              ),
            ),
          );
        });
  }
}
