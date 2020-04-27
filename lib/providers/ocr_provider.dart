import 'dart:convert';
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

  String get _demo =>
      json.encode({
        'merchant': 'Boston Pizza',
        'name': 'BP',
        'date': "2017-09-14",
        'tps': 0.80,
        'tvp': 1.59,
        'items': [
          {'name': 'Ceasar Classique', 'price': 6.99},
          {'name': 'G-BBQ Poulet', 'price': 8.99},
        ],
      });

  set extractedText(String text) {
    _extractedText = text;
    notifyListeners(); // trigger widget rebuild
  }

  /// Parse images into text
  void scanImage(File image) async {
    // TODO: run LOTS of image pre-processing:
    //  greyscale, auto-crop, filters (highlight, sharpen, etc.), compensate for angle


    // TODO: chunk image into lines and run ocr line by line for better accuracy



    _ocr.scanImage(image).then((value) {
      Logger.log('image scan complete');
      extractedText = _demo + "\n\n" + value;
    });
  }

  /// Parse receipt pictures into text
  void scanReceipt(Receipt receipt) {
    return scanImage(receipt.picture);
  }

  Receipt parseExtractedText() {
    return Receipt.fromJson(jsonDecode(_demo));
  }
}

