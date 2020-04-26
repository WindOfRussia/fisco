import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ocr_provider.dart';

/// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  File image;

  DisplayPictureScreen({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: (image == null) ? Text('No Image to display') :
      Stack(
        children: [
          Image.file(image),
          Container(
            child: Align(
              child: Consumer<OcrProvider>( // another way of using providers
                builder: (_, ocr, child) {
                  return Text(ocr?.extractedText ?? 'Processing....');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}