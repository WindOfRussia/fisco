library fisco_app.globals;
import './models/receipt.dart';
import './models/line_item.dart';

var receipts = [
  Receipt(
      name: "Receipt 1",
      category: Categories.Clothes,
      date: new DateTime(2020,04,25),
      items: [
        LineItem(name: "Item 1", price: 80.00),
        LineItem(name: "Item 2", price: 20.00),
        LineItem(name: "Item 3", price: 26.00),
        LineItem(name: "Item 4", price: 98.00),
      ]
  ),
  Receipt(
      name: "Receipt 2",
      category: Categories.Groceries,
      total: 200.00,
      date: new DateTime(2020,04,25)
  ),
  Receipt(
      name: "Receipt 3",
      category: Categories.Clothes,
      total: 100.00,
      date: new DateTime(2020,04,18)
  ),
  Receipt(
      name: "Receipt 4",
      category: Categories.Groceries,
      total: 300.00,
      date: new DateTime(2020,04,18)
  ),
  Receipt(
      name: "Receipt 5",
      category: Categories.Other,
      total: 250.00,
      date: new DateTime(2020,04,18)
  ),
  Receipt(
      name: "Receipt 6",
      category: Categories.Restaurants,
      total: 200.00,
      date: new DateTime(2020,04,19)
  ),
  Receipt(
      name: "Receipt 7",
      category: Categories.Clothes,
      total: 200.00,
      date: new DateTime(2020,04,19)
  ),
  Receipt(
      name: "Receipt 8",
      category: Categories.Other,
      total: 250.00,
      date: new DateTime(2020,04,19)
  ),
  Receipt(
      name: "Receipt 9",
      category: Categories.Other,
      total: 100.00,
      date: new DateTime(2020,03,29)
  ),
  Receipt(
      name: "Receipt 10",
      category: Categories.Clothes,
      total: 100.00,
      date: new DateTime(2020,03,29)
  ),
];
