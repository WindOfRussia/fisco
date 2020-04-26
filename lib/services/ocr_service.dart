import 'dart:io';

/// Interface for OCR services to standardize usage if we need to swap backend
abstract class OcrService {

  /// As long as it returns text I don't care what it does
  Future<String> scanImage(File image);

}