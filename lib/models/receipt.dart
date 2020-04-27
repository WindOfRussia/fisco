import 'dart:io';
import 'package:enum_to_string/enum_to_string.dart';
import 'model.dart';
import 'line_item.dart';

enum Categories {
  Restaurants, Groceries, Clothes, Other
}

class Receipt implements Model {
  double _tps, _tvp, _total;
  Categories category = Categories.Other;
  String name = "";
  //optional
  File picture;
  String merchant;
  String note;
  DateTime date = new DateTime.now();
  List<LineItem> items = [
    LineItem(name: "Chicken Tenders", price: 10.99)
  ];

  get itemCount => items.length;

  set tps(double value) => _tps = value;
  set tvp(double value) => _tvp = value;

  get tps {
    var computed = subtotal * 0.05;
    if (_tps == null || _tps == 0) {
      return num.parse(computed.toStringAsFixed(2));
    }
    return _tps;
  }

  get tvp {
    var computed = subtotal * 0.09975;
    if (_tvp == null || _tvp == 0) {
      return num.parse(computed.toStringAsFixed(2));
    }
    return _tvp;
  }

  get subtotal {
    double computed = 0;
    if (items != null) {
      for (var item in items) computed += item.price;
    }
    return num.parse(computed.toStringAsFixed(2));
  }

  get total {
    double computed = subtotal;
    if (tps != null) {
      computed += tps;
    }
    if (tvp != null) {
      computed += tvp;
    }
    return num.parse(computed.toStringAsFixed(2));
  }

  String get categoryText => EnumToString.parse(category);


  // Making all fields optional on create to account for ocr issues
  Receipt({
    this.picture,
    this.merchant,
    this.name,
    this.category,
    this.date,
    tps,
    tvp,
    this.note,
    this.items
  }) {
    this.tps = tps;
    this.tvp = tvp;
  }

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
      'subtotal': subtotal,
      'total': total,
      'note': note,
      'items': items,
    };
  }

  factory Receipt.fromJson(Map<String, dynamic> json) {
    List items = json['items'].map((value) => new LineItem.fromJson(value)).toList();
    var receipt = new Receipt(
        picture: json['picture'] != null ? File(json['picture']) : null,
        merchant: json['merchant'],
        name: json['name'] ?? "",
        category: EnumToString.fromString(Categories.values, json['category']),
        date: DateTime.parse(json['date']),
        note: json['note'],
        tps: json['tps'],
        tvp: json['tvp'],
        items: items.cast<LineItem>(),
    );
    return receipt;
  }

  factory Receipt.fromFile(
      File picture,
      {name, category, date, items}
    )
  {
    //TODO: RUN OCR & PARSE IMAGE INTO RECEIPT HERE

    return new Receipt(
        name: name,
        category: category,
        date: date,
        items: items,
    );
  }

    factory Receipt.example() {
      return Receipt(
        date: DateTime.now(),
        category:Categories.Other,
        name : "New Receipt",
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
