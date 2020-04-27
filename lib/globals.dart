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
      ],
  ),
  Receipt(
      name: "Receipt 2",
      category: Categories.Groceries,
      date: new DateTime(2020,04,25),
      items: [
        LineItem(name: "Item 1", price: 80.00),
      ],
  ),
  Receipt(
      name: "Receipt 3",
      category: Categories.Clothes,
      date: new DateTime(2020,04,18),
      items: [
        LineItem(name: "Item 1", price: 80.00),
        LineItem(name: "Item 2", price: 20.00),
        LineItem(name: "Item 3", price: 226.00),
      ],
  ),
  Receipt(
      name: "Receipt 4",
      category: Categories.Groceries,
      date: new DateTime(2020,04,18),
      items: [
        LineItem(name: "Item 1", price: 80.00),
        LineItem(name: "Item 2", price: 20.00),
        LineItem(name: "Item 3", price: 26.00),
        LineItem(name: "Item 4", price: 98.00),
        LineItem(name: "Item 5", price: 98.00),
        LineItem(name: "Item 6", price: 98.00),
        LineItem(name: "Item 7", price: 98.00),
      ],
  ),
  Receipt(
      name: "Receipt 5",
      category: Categories.Other,
      date: new DateTime(2020,04,18),
      items: [
        LineItem(name: "Item 1", price: 820.00),
        LineItem(name: "Item 2", price: 260.00),
        LineItem(name: "Item 3", price: 26.00),
        LineItem(name: "Item 4", price: 968.00),
      ],
  ),
  Receipt(
      name: "Receipt 6",
      category: Categories.Restaurants,
      date: new DateTime(2020,04,19),
      items: [
        LineItem(name: "Item 1", price: 808.00),
        LineItem(name: "Item 2", price: 240.00),
      ],
  ),
  Receipt(
      name: "Receipt 7",
      category: Categories.Clothes,
      date: new DateTime(2020,04,19),
      items: [
        LineItem(name: "Item 1", price: 80.00),
        LineItem(name: "Item 2", price: 20.00),
        LineItem(name: "Item 3", price: 26.00),
        LineItem(name: "Item 4", price: 98.00),
      ],
  ),
  Receipt(
      name: "Receipt 8",
      category: Categories.Other,
      date: new DateTime(2020,04,19),
      items: [
        LineItem(name: "Item 1", price: 820.00),
        LineItem(name: "Item 2", price: 230.00),
        LineItem(name: "Item 3", price: 264.00),
        LineItem(name: "Item 4", price: 98.00),
      ],
  ),
  Receipt(
      name: "Receipt 9",
      category: Categories.Other,
      date: new DateTime(2020,03,29),
      items: [
        LineItem(name: "Item 1", price: 870.00),
        LineItem(name: "Item 2", price: 20.00),
        LineItem(name: "Item 3", price: 256.00),
        LineItem(name: "Item 4", price: 980.00),
      ],
  ),
  Receipt(
      name: "Receipt 10",
      category: Categories.Clothes,
      date: new DateTime(2020,03,29),
      items: [
        LineItem(name: "Item 1", price: 80.00),
        LineItem(name: "Item 2", price: 20.00),
        LineItem(name: "Item 3", price: 126.00),
      ],
  ),
];
