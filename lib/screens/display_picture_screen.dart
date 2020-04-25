import 'package:flutter/material.dart';
import 'dart:io';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  File image;

  DisplayPictureScreen({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: (image != null) ? Image.file(image) : Text('No Image to display'),
    );
  }
}