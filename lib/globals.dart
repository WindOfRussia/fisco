library fisco_app.globals;

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