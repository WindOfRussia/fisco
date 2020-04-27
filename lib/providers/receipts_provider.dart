import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../services/storage_service.dart';
import '../services/logger_service.dart';
import '../services/analysis_service.dart';
import '../models/receipt.dart';

class ReceiptsProvider extends ChangeNotifier {
  List<Receipt> _receipts = [];

  List<Receipt> get receipts => _receipts;

  set receipts(List<Receipt> receipts) {
    _receipts = receipts;
    analysisService.receipts = receipts;
    Logger.log('receipts updated');
    syncToStorage();
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

  Receipt _currentReceipt;
  Receipt get currentReceipt {
    if (_currentReceipt == null) {
      openReceipt(); // opens generic new receipt
    }
    return _currentReceipt;
  }
  int _editIndex;
  Receipt get editIndex => editIndex;

  /// Initialize Provider
  ReceiptsProvider() {
    syncFromStorage();
  }

  /// Edit an existing receipt or open a new one
  /// for
  void openReceipt({int index, Receipt receipt}) {
    if (index != null) {
      _editIndex = index;
    }

    if(receipt != null) {
      _currentReceipt = receipt;
    } else if (_editIndex != null) {
      _currentReceipt = receipts[index];
    } else { // open a generic new receipt
      _editIndex = null;
      _currentReceipt = Receipt.example();
    }
    
    notifyListeners();
  }

  /// Update currently opened receipt
  void updateOpenReceipt(Receipt receipt) {
    openReceipt(receipt: receipt); //overwrite open receipt with a newer one
  }

  /// Save temp receipt to memory
  void saveOpenReceipt({int index, Receipt receipt}) {
    if(_editIndex != null || index != null) {
      receipts[index ?? _editIndex] = receipt ?? _currentReceipt;
    } else {
      receipts.add(receipt ?? _currentReceipt);
    }
    analysisService.receipts = receipts;
    closeReceipt();
  }

  /// Close temp receipt
  void closeReceipt() {
    _currentReceipt = null;
    _editIndex = null;
    syncToStorage();
    notifyListeners();
  }

  void addReceipt(Receipt receipt) {
    receipts.add(receipt);
    analysisService.receipts = receipts;
    syncToStorage();
    notifyListeners();
  }

  void removeReceipt(Receipt receipt) {
    receipts.remove(receipt);
    analysisService.receipts = receipts;
    syncToStorage();
    notifyListeners();
  }

  void removeReceiptAt(int index) {
    receipts.removeAt(index);
    analysisService.receipts = receipts;
    syncToStorage();
    notifyListeners();
  }

  void syncToStorage() {
    Storage.store('receipts', receipts);
  }

  void syncFromStorage() {
    Storage.retrieve('receipts').then((value) {
      if(value == null || value.isEmpty == true) {
        receipts = globals.receipts; // example data
      } else {
        receipts = value.map((e) => Receipt.fromJson(e)).toList();
      }
    });
  }
}