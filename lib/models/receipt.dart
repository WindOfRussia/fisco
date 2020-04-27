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
  String name = "";
  //optional
  File picture;
  String merchant;
  String note;
  DateTime date = new DateTime.now();
  List<LineItem> items = [];

  get itemCount => items.length;

  String get categoryText => EnumToString.parse(category);

  double get computeTotal {
    double computed = 0;
    if (items != null) {
      for (var item in items) computed += item.price;
    }
    if (tps != null) {
      computed += tps;
    }
    if (tvp != null) {
      computed += tvp;
    }
    if (total == null || total < computed) {
      total = computed;
    }
    return computed;
  }


  // Making all fields optional on create to account for ocr issues
  Receipt({
    this.picture,
    this.merchant,
    this.name,
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
      'name' : name,
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
        name: json['name'] ?? "",
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
      {name, category, date, tps, tvp, total, items}
    )
  {
    //TODO: RUN OCR & PARSE IMAGE INTO RECEIPT HERE

    return new Receipt(
        name: name,
        category: category,
        date: date,
        tps: tps,
        tvp: tvp,
        total: total,
        items: items,
    );
  }

    factory Receipt.example() {
      return Receipt(
        date: DateTime.now(),
        category:Categories.Other,
        name : "New Receipt",
        tps: 0.0,
        tvp: 0.0,
        items: [
          LineItem(name: "Item 1", price: 10.00),
          LineItem(name: "Item 2", price: 15.00),
          LineItem(name: "Item 3", price: 5.00),
          LineItem(name: "Item 4", price: 2.50),
        ]
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
