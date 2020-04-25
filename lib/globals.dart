library fisco_app.globals;
import './models/receipt.dart';

var receipts = [
  Receipt(category: Categories.Clothes, total: 100.00, date: new DateTime(2020,04,25)),
  Receipt(category: Categories.Groceries, total: 200.00, date: new DateTime(2020,04,25)),
  Receipt(category: Categories.Clothes, total: 100.00, date: new DateTime(2020,04,18)),
  Receipt(category: Categories.Groceries, total: 300.00, date: new DateTime(2020,04,18)),
  Receipt(category: Categories.Other, total: 250.00, date: new DateTime(2020,04,18)),
  Receipt(category: Categories.Restaurants, total: 200.00, date: new DateTime(2020,04,19)),
  Receipt(category: Categories.Clothes, total: 200.00, date: new DateTime(2020,04,19)),
  Receipt(category: Categories.Other, total: 250.00, date: new DateTime(2020,04,19)),
  Receipt(category: Categories.Other, total: 100.00, date: new DateTime(2020,03,29)),
  Receipt(category: Categories.Clothes, total: 100.00, date: new DateTime(2020,03,29)),
];
