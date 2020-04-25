import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  CameraButton();

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.camera_alt),
          onPressed: () {}
          );
  }
}