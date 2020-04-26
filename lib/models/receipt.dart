import 'dart:io';
import 'package:enum_to_string/enum_to_string.dart';
import 'model.dart';
import 'line_item.dart';

enum Categories {
  Restaurants, Groceries, Clothes, Other
}

class Receipt implements Model {
  double tps = 0, tvp = 0, total = 0;
  Categories category = Categories.Other;

  //optional
  File picture;
  String merchant;
  String note;
  DateTime date = new DateTime.now();
  List<LineItem> items = [];

  get itemCount => items.length;

  String get categoryText => EnumToString.parse(category);


  // Making all fields optional on create to account for ocr issues
  Receipt({
    this.picture,
    this.merchant,
    this.category,
    this.date,
    this.tps,
    this.tvp,
    this.total,
    this.note,
    this.items
  });

  Map toJson() {
    List<Map> items =
    this.items != null ? this.items.map((i) => i.toJson()).toList() : null;

    return {
      'picture': picture?.path,
      'merchant': merchant,
      'category': EnumToString.parse(category),
      'date': date.toString(),
      'tps': tps,
      'tvp': tvp,
      'total': total,
      'note': note,
      'items': items,
    };
  }

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return new Receipt(
        picture: json['picture'] != null ? File(json['picture']) : null,
        merchant: json['merchant'],
        category: EnumToString.fromString(Categories.values, json['category']),
        date: DateTime.parse(json['date']),
        tps: json['tps'] ?? 0,
        tvp: json['tvp'] ?? 0,
        total: json['total'] ?? 0,
        note: json['note'],
        items: json['items'].map((value) => new LineItem.fromJson(value)).toList()
    );
  }

  factory Receipt.fromFile(
      File picture,
      {category, date, tps, tvp, total, items}
    )
  {
    //TODO: RUN OCR & PARSE IMAGE INTO RECEIPT HERE

    return new Receipt(
        category: category,
        date: date,
        tps: tps,
        tvp: tvp,
        total: total,
        items: items,
    );
  }

  static List<Receipt> filterByDate(List<Receipt> receipts, {DateTime start, DateTime end}) {
    var it = receipts.iterator;
    List<Receipt> filteredData = [];
    while (it.moveNext()) {
      if (end != null && start != null) {
        if (it.current.date.compareTo(start) >= 0 && it.current.date.compareTo(end) <= 0) {
          filteredData.add(it.current);
        }
      } else if (start != null && end == null) {
        if (it.current.date.compareTo(start) >= 0) {
          filteredData.add(it.current);
        }
      } else if (end != null && start == null) {
        if (it.current.date.compareTo(end) <= 0) {
          filteredData.add(it.current);
        }
      }
    }
    return filteredData;
  }

}
