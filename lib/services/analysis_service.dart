import 'package:charts_flutter/flutter.dart' as charts;
import '../models/category_vs_total.dart';
import '../models/receipt.dart';

class AnalysisService {
  List<String> dataInterval = ['Last Week', 'Last Month', 'Current Week', 'Current Month'];
  String _selectedDataInterval = 'Last Week';

  get selectedDataInterval => _selectedDataInterval;
  set selectedDataInterval(String selected) {
    _selectedDataInterval = selected;
    refreshChartData();
  }

  List<Receipt> _receipts = [];
  set receipts(List<Receipt> receipts) {
    _receipts = receipts;
    refreshChartData();
  }

  List<charts.Series<CategoryVsTotal, String>> pieChartData;
  List<charts.Series<CategoryVsTotal, String>> barChartData;

  // Recent Dates
  DateTime get _now => DateTime.now();
  DateTime get _firstDayOfCurrentMonth => DateTime(_now.year, _now.month, 1);
  DateTime get _firstDayOfCurrentWeek => _now.subtract(Duration(days: _now.weekday));

  // Last Week
  DateTime get _firstDayOfLastWeek => _now.subtract(Duration(days: _now.weekday + 7));
  DateTime get _lastDayOfLastWeek => _now.subtract(Duration(days: _now.weekday - 1));

  // Last Month
  DateTime get _firstDayOfLastMonth => DateTime(_now.year, _now.month - 1, 1);
  DateTime get _lastDayOfLastMonth => DateTime(_now.year, _now.month, 0);

  static int chartCount = 0;


  void refreshChartData() {
    List<Receipt> filtered = _filterReceipts();
    // Update chart data
    pieChartData = chartDataFromReceipts(filtered, shades: true);
    barChartData = chartDataFromReceipts(filtered);
  }

  List<Receipt> _filterReceipts() {
    switch (_selectedDataInterval) {
      case 'Last Week':
        return Receipt.filterByDate(_receipts, start: _firstDayOfLastWeek, end: _lastDayOfLastWeek);
      case 'Last Month':
        return Receipt.filterByDate(_receipts, start: _firstDayOfLastMonth, end: _lastDayOfLastMonth);
      case 'Current Month':
        return Receipt.filterByDate(_receipts, start: _firstDayOfCurrentMonth);
      default:
        return Receipt.filterByDate(_receipts, start: _firstDayOfCurrentWeek);
    }
  }

  List<charts.Series<CategoryVsTotal, String>> chartDataFromReceipts(List<Receipt> receipts, {shades: false}) {
    var list = CategoryVsTotal.fromReceipts(receipts);
    return chartData(list, shades: shades);
  }

  List<charts.Series<CategoryVsTotal, String>> chartData(List<CategoryVsTotal> dataSet, {shades: false}) {
    // build a chart id
    String id = "chart_${AnalysisService.chartCount}";
    AnalysisService.chartCount++;

    // copy data to avoid modifying original
    List<CategoryVsTotal> data = new List<CategoryVsTotal>.from(dataSet);

    // Sort data automatically by ascending order
    if(shades == true) {
      data.sort((a, b) => a.total.compareTo(b.total));
    }
    return [
      charts.Series<CategoryVsTotal, String>(
        id: id,
        colorFn: (_, index) {
          var palette = charts.MaterialPalette.indigo;
          if (shades == false) {
            return palette.shadeDefault;
          }
          int dataSize = data.length+1;
          int startingColorIndex = data.length-1;
          return palette.makeShades(dataSize)[startingColorIndex-index];
        },
        domainFn: (CategoryVsTotal dataPoint, _) => dataPoint.category,
        measureFn: (CategoryVsTotal dataPoint, _) => dataPoint.total,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (CategoryVsTotal row, _) => '${row.category}',
      )
    ];
  }


}