import 'dart:io';
import 'line_item.dart';

enum Categories {
  Restaurants, Groceries, Clothes, Other
}

class Receipt {
  double tps = 0, tvp = 0, total = 0;
  Categories category = Categories.Other;

  //optional
  DateTime date = new DateTime.now();
  List<LineItem> items = [];
  File picture;
  String note;


  // Making all fields optional on create to account for ocr issues
  Receipt({
    this.picture,
    this.category,
    this.date,
    this.tps,
    this.tvp,
    this.total,
    this.items
  });

  factory Receipt.fromFile(File picture, category, date, tps, tvp, total, items) {
    return new Receipt(
        category: category,
        date: date,
        tps: tps,
        tvp: tvp,
        total: total,
        items: items,
    );
  }

}
