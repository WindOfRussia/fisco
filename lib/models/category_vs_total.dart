import 'receipt.dart';

class CategoryVsTotal {
  final String category;
  final double total;

  CategoryVsTotal(this.category, this.total);

  static List<CategoryVsTotal> fromReceipts(List<Receipt> receipts) {
    var map = {};
    receipts.forEach((receipt) => map.putIfAbsent(receipt.categoryText, ()=>0));
    receipts.forEach((receipt) => map[receipt.categoryText] += receipt.total);
    List<CategoryVsTotal> list = [];
    map.entries.forEach((e) => list.add(CategoryVsTotal(e.key.toString(), e.value)));
    return list;
  }
}