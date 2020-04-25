import 'dart:collection';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../models/receipt.dart';
import '../widgets/fisco_bottom_bar.dart';
import '../widgets/buttons/camera_button.dart';

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnalysisPageState();
}
/// This is a visualization widget that will build our visualization
class _AnalysisPageState extends State<AnalysisPage> {
  List<String> _dataInterval = ['Last Week', 'Last Month', 'Current Week', 'Current Month'];
  String _selectedDataInterval = 'Last Week';
  static var today = DateTime.now();
  static var lastWeekData = _mapCategoryVsTotalDataSet(_filterReceiptsByLastWeek(today));
  static var lastMonthData = _mapCategoryVsTotalDataSet(_filterReceiptsByLastMonth(today));
  static var currentWeekData = _mapCategoryVsTotalDataSet(_filterReceiptsByCurrentWeek(today));
  static var currentMonthData = _mapCategoryVsTotalDataSet(_filterReceiptsByCurrentMonth(today));
  var currentData = lastWeekData;

  @override
  Widget build(BuildContext context) {
    {

      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CameraButton(),
        bottomNavigationBar: FiscoBottomBar(
          children: [
            IconButton(icon: Icon(Icons.more_horiz),
              onPressed: () => Navigator.pushNamed(context, '/manage')
            ),
            IconButton(icon: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/new')
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                hint: Text('Please choose a data interval'),
                value: _selectedDataInterval,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDataInterval = newValue;
                    switch (newValue) {
                      case "Last Week":
                        currentData = lastWeekData;
                        break;
                      case "Last Month":
                        currentData = lastMonthData;
                        break;
                      case "Current Week":
                        currentData = currentWeekData;
                        break;
                      case "Current Month":
                        currentData = currentMonthData;
                        break;
                    }
                  });
                },
                items: _dataInterval.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.PieChart(
                    _createPieChartData(currentData),
                    animate: true,
                    behaviors: [
                      new charts.DatumLegend(position: charts.BehaviorPosition.end)
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.BarChart(
                    _createBarChartData(currentData),
                    animate: true,
                  ),
                )
            ],
          ),
        ),
      );
    }
  }

  static List<charts.Series<CategoryVsTotal, String>>
  _createBarChartData(List<CategoryVsTotal> dataSet) {
    var data = new List<CategoryVsTotal>.from(dataSet);
    return [
      charts.Series<CategoryVsTotal, String>(
        id: 'BarChart',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (CategoryVsTotal dataPoint, _) =>
        dataPoint.category,
        measureFn: (CategoryVsTotal dataPoint, _) =>
        dataPoint.total,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (CategoryVsTotal row, _) => '${row.category}',
      )
    ];
  }
  static List<charts.Series<CategoryVsTotal, String>>
  _createPieChartData(List<CategoryVsTotal> dataSet) {
    var data = new List<CategoryVsTotal>.from(dataSet);
    // Sort data automatically by ascending order
    data.sort((a, b) => a.total.compareTo(b.total));
    int dataSize = data.length+1;
    int startingColorIndex = data.length-1;
    return [
      charts.Series<CategoryVsTotal, String>(
        id: 'PieChart',
        colorFn: (_, index) {
          return charts.MaterialPalette.indigo.makeShades(dataSize)[startingColorIndex-index];
        },
        domainFn: (CategoryVsTotal dataPoint, _) =>
        dataPoint.category,
        measureFn: (CategoryVsTotal dataPoint, _) =>
        dataPoint.total,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (CategoryVsTotal row, _) => '${row.category}',
      )
    ];
  }
  static List<Receipt> _filterReceiptsByLastWeek(DateTime date) {
    var lastDayOfLastWeek = date.subtract(new Duration(days: date.weekday - 1));
    var firstDayOfLastWeek = date.subtract(new Duration(days: date.weekday + 7));
    var it = globals.receipts.iterator;
    List<Receipt> filteredData = [];
    while (it.moveNext()) {
      if (it.current.date.compareTo(firstDayOfLastWeek) >= 0 && it.current.date.compareTo(lastDayOfLastWeek) <= 0)
        filteredData.add(it.current);
    }
    return filteredData;
  }
  static List<Receipt> _filterReceiptsByCurrentWeek(DateTime date) {
    var firstDayOfCurrentWeek = date.subtract(new Duration(days: date.weekday));
    var it = globals.receipts.iterator;
    List<Receipt> filteredData = [];
    while (it.moveNext()) {
      if (it.current.date.compareTo(firstDayOfCurrentWeek) >= 0)
        filteredData.add(it.current);
    }
    return filteredData;
  }
  static List<Receipt> _filterReceiptsByLastMonth(DateTime date) {
    var lastDayOfLastMonth = new DateTime(date.year,date.month,0);
    var firstDayOfLastMonth = new DateTime(date.year,date.month-1,1);
    var it = globals.receipts.iterator;
    List<Receipt> filteredData = [];
    while (it.moveNext()) {
      if (it.current.date.compareTo(firstDayOfLastMonth) >= 0 && it.current.date.compareTo(lastDayOfLastMonth) <= 0)
        filteredData.add(it.current);
    }
    return filteredData;
  }
  static List<Receipt> _filterReceiptsByCurrentMonth(DateTime date) {
    var firstDayOfCurrentMonth = new DateTime(date.year,date.month,1);
    var it = globals.receipts.iterator;
    List<Receipt> filteredData = [];
    while (it.moveNext()) {
      if (it.current.date.compareTo(firstDayOfCurrentMonth) >= 0)
        filteredData.add(it.current);
    }
    return filteredData;
  }
  static List<CategoryVsTotal> _mapCategoryVsTotalDataSet(List<Receipt> receipts) {
    var map = {};
    receipts.forEach((receipt) => map.putIfAbsent(receipt.category.toString().split('.').last, ()=>0));
    receipts.forEach((receipt) => map[receipt.category.toString().split('.').last] += receipt.total);
    List<CategoryVsTotal> list = [];
    map.entries.forEach((e) => list.add(CategoryVsTotal(e.key.toString(), e.value)));
    return list;
  }
}
class CategoryVsTotal {
  final String category;
  final double total;

  CategoryVsTotal(this.category, this.total);
}