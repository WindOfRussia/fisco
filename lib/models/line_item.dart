import 'model.dart';

class LineItem implements Model {
  String name;
  double price;

  LineItem({this.name, this.price});

  Map toJson() => {
    'name': name,
    'price': price,
  };

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return new LineItem(
      name: json['name'],
      price: json['tps'] ?? 0,
    );
  }

}