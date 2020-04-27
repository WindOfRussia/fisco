import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'logger_service.dart';
import 'ocr_service.dart';

/// Concrete implementation of OcrService using a tesseract api plugin
class TesseractService implements OcrService {
  String lastExtracted;

  Future<String> scanImage(File image) async {
    try {
      lastExtracted = await TesseractOcr.extractText(image?.path, language: 'eng+fra');
      Logger.log('tesseract scan complete', object: lastExtracted);
    } on PlatformException {
      Logger.log('tesseract scan failed', object: PlatformException);
      return "Failed to extract text";
    }
    return lastExtracted;
  }

}