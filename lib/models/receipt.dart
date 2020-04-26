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

  Map toJson() {
    List<Map> items =
    this.items != null ? this.items.map((i) => i.toJson()).toList() : null;

    return {
      'picture': picture?.path,
      'category': EnumToString.parse(category),
      'date': date.toString(),
      'tps': tps,
      'tvp': tvp,
      'total': total,
      'items': items,
    };
  }

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return new Receipt(
        picture: json['picture'] != null ? File(json['picture']) : null,
        category: EnumToString.fromString(Categories.values, json['category']),
        date: DateTime.parse(json['date']),
        tps: json['tps'] ?? 0,
        tvp: json['tvp'] ?? 0,
        total: json['total'] ?? 0,
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

}
