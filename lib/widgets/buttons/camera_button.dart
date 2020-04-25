import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

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
    Navigator.pushNamed(context, '/picture', arguments: picture).
      whenComplete(() => Navigator.pop(context)); //dismiss alert
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
