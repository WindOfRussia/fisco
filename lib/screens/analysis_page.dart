import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/receipts_provider.dart';
import '../widgets/fisco_bottom_bar.dart';
import '../widgets/buttons/camera_button.dart';

/// This is a visualization widget that will build our visualization
class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Providers follow Observer pattern: any time ReceiptsProvider calls notifyListeners(), this widget will refresh
    // var provider = Provider.of<ReceiptsProvider>(context); // Grab provider using context and access all its data anywhere

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
              value: Provider.of<ReceiptsProvider>(context).selectedDataInterval, // any time selected attribute is updated, the dropdown button widget will rebuild
              onChanged: (value) {
                Provider.of<ReceiptsProvider>(context, listen: false). // passing false means we don't want to refresh the widget if this next call ever uses notifyListeners
                  selectedDataInterval = value; // normally setters should specify listen false and let the corresponding getters refresh the widget... avoids endless loops
              },
              items: Provider.of<ReceiptsProvider>(context).analysisService.dataInterval.map((item) {
                return DropdownMenuItem(
                  child: new Text(item),
                  value: item,
                );
              }).toList(),
            ),
              Consumer<ReceiptsProvider>( builder: (_, provider, child) => // alternative way of accessing the provider, useful if you're only retrieving attributes and expect to listen to changes
                SizedBox(
                  width: 300,
                  height: 200,
                  child: charts.PieChart(
                    provider.pieChartData,
                    animate: true,
                    behaviors: provider.pieChartData == null ? [] : [
                      new charts.DatumLegend(position: charts.BehaviorPosition.end)
                    ],
                  ),
                )
              ),
              SizedBox(
                width: 300,
                height: 200,
                child: charts.BarChart(
                  Provider.of<ReceiptsProvider>(context).barChartData, // Or keep using this way...
                  animate: true,
                ),
              )
          ],
        ),
      ),
    );
  }
}