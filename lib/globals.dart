library fisco_app.globals;
import './models/receipt.dart';

var receipts = [
  Receipt(category: Categories.Clothes, total: 20.12, date: new DateTime(2020,18,03)),
  Receipt(category: Categories.Groceries, total: 300.00, date: new DateTime(2020,18,03)),
  Receipt(category: Categories.Other, total: 250.12, date: new DateTime(2020,18,03)),
  Receipt(category: Categories.Restaurants, total: 200.12, date: new DateTime(2020,19,03)),
  Receipt(category: Categories.Clothes, total: 200.00, date: new DateTime(2020,19,03)),
];
