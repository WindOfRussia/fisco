library fisco_app.globals;

Receipt tempReceipt;

var receipts = [];
var lastWeekDataSet = [
  LastWeekCategoryVsExpense("Groceries", 100.00),
  LastWeekCategoryVsExpense("Restaurants", 50.00),
  LastWeekCategoryVsExpense("Clothes", 150.00),
  LastWeekCategoryVsExpense("Others", 200.00),
];

var lastMonthDataSet = [
  LastWeekCategoryVsExpense("Groceries", 300.00),
  LastWeekCategoryVsExpense("Restaurants", 300.00),
  LastWeekCategoryVsExpense("Clothes", 250.00),
  LastWeekCategoryVsExpense("Others", 500.00),
];

class LastWeekCategoryVsExpense {
  final String category;
  final double expense;

  LastWeekCategoryVsExpense(this.category, this.expense);
}

class Receipt {
  String file = "";
  String category = "Others";
  var date = new DateTime.now();
  double TPS = 0, TVP = 0, total = 0;
  List<Item> items = [];

  Receipt(this.file, this.category,this.date, this.TPS, this.TVP, this.total, this.items);

}
class Item {
  String name;
  double price;
}