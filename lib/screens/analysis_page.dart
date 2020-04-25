import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'widgets/buttons/CameraButton.dart';

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnalysisPageState();
}
/// This is a visualization widget that will build our visualization
class _AnalysisPageState extends State<AnalysisPage> {
  List<String> _dataInterval = ['Last Week', 'Last Month'];
  String _selectedDataInterval = 'Last Week';
  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CameraButton(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.teal,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.more_horiz), onPressed: () {
                  Navigator.pushNamed(context, '/manage');
                },
              ),
              IconButton(icon: Icon(Icons.add), onPressed: () {
                  Navigator.pushNamed(context, '/new');
                },
              ),
            ],
          ),
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
                  });
                },
                items: _dataInterval.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
              if (_selectedDataInterval == 'Last Week') ... [
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.PieChart(
                    _createPieChartData(lastWeekDataSet),
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
                    _createBarChartData(lastWeekDataSet),
                    animate: true,
                  ),
                )
              ]
              else if (_selectedDataInterval == 'Last Month') ... [
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.PieChart(
                    _createPieChartData(lastMonthDataSet),
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
                    _createBarChartData(lastMonthDataSet),
                    animate: true,
                  ),
                )
              ]
            ],
          ),
        ),
      );
    }
  }

  static List<charts.Series<LastWeekCategoryVsExpense, String>>
  _createBarChartData(List<LastWeekCategoryVsExpense> dataSet) {
    var data = new List<LastWeekCategoryVsExpense>.from(dataSet);
    return [
      charts.Series<LastWeekCategoryVsExpense, String>(
        id: 'LastWeekBarChart',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.category,
        measureFn: (LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.expense,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LastWeekCategoryVsExpense row, _) => '${row.category}',
      )
    ];
  }
  static List<charts.Series<LastWeekCategoryVsExpense, String>>
  _createPieChartData(List<LastWeekCategoryVsExpense> dataSet) {
    var data = new List<LastWeekCategoryVsExpense>.from(dataSet);
    // Sort data automatically by ascending order
    data.sort((a, b) => a.expense.compareTo(b.expense));
    int dataSize = data.length+1;
    int startingColorIndex = data.length-1;

    return [
      charts.Series<LastWeekCategoryVsExpense, String>(
        id: 'LastWeekBarChart',
        colorFn: (_, index) {

          return charts.MaterialPalette.indigo.makeShades(dataSize)[startingColorIndex-index];
        },
        domainFn: (LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.category,
        measureFn: (LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.expense,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LastWeekCategoryVsExpense row, _) => '${row.category}',
      )
    ];
  }
  static List<LastWeekCategoryVsExpense> _createLastMonthDataSet(DateTime date) {
    var firstDayOfLastWeek = date.subtract(new Duration(days: date.weekday + 7));
    while ()
  }
}

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