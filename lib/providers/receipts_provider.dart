import 'package:fiscoapp/services/analysis_service.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../services/storage_service.dart';
import '../services/logger_service.dart';
import '../models/receipt.dart';

class ReceiptsProvider extends ChangeNotifier {
  List<Receipt> _receipts = [];

  List<Receipt> get receipts => _receipts;

  set receipts(List<Receipt> receipts) {
    _receipts = receipts;
    analysisService.receipts = receipts;
    Logger.log('receipts updated', object: receipts, level: 1000);
    notifyListeners();  // triggers rebuilt of all listening widgets
  }

  // Data Visualisation Service
  AnalysisService analysisService = AnalysisService();

  get pieChartData => analysisService.pieChartData;
  get barChartData => analysisService.barChartData;

  get selectedDataInterval => analysisService.selectedDataInterval;
  set selectedDataInterval(String selectedDataInterval) {
    analysisService.selectedDataInterval = selectedDataInterval;
    notifyListeners();
  }

  /// Initialize Provider
  ReceiptsProvider() {
    _exampleSeed(); // or in this case just dump some random data into receipts
  }

  void addReceipt(Receipt receipt) {
    receipts.add(receipt);
    analysisService.receipts = receipts;
    notifyListeners();
  }

  void removeReceipt(Receipt receipt) {
    receipts.remove(receipt);
    analysisService.receipts = receipts;
    notifyListeners();
  }

  /// random data
  void _exampleSeed() {
    receipts = globals.receipts;
  }

/* Wasted enough time already, just ignore these
  void syncToStorage() {
    Storage.store('receipts', receipts);
  }

  List<Receipt> syncFromStorage() {
    return Storage.retrieve('receipts');
  }
*/
}