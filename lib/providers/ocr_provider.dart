import 'dart:io';
import 'package:flutter/material.dart';
import '../models/receipt.dart';
import '../services/logger_service.dart';
import '../services/ocr_service.dart';
import '../services/tesseract_service.dart';

class OcrProvider extends ChangeNotifier {
  OcrService _ocr = TesseractService();
  String _extractedText;

  String get extractedText => _extractedText;

  set extractedText(String text) {
    _extractedText = text;
    notifyListeners(); // trigger widget rebuild
  }

  /// Parse images into text
  void scanImage(File image) {
    // TODO: run LOTS of image pre-processing:
    //  greyscale, auto-crop, filters (highlight, sharpen, etc.), compensate for angle


    // TODO: chunk image into lines and run ocr line by line for better accuracy



    _ocr.scanImage(image).then((value) {
      Logger.log('image scan complete');
      extractedText = value;
    });
  }

  /// Parse receipt pictures into text
  void scanReceipt(Receipt receipt) {
    return scanImage(receipt.picture);
  }
}

