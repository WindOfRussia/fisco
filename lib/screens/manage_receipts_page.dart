import 'package:fiscoapp/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../globals.dart' as globals;
import '../providers/receipts_provider.dart';
import '../widgets/fisco_bottom_bar.dart';
import '../widgets/buttons/camera_button.dart';
import 'package:intl/intl.dart';

class ManageReceiptsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageReceiptsPageState();
}

class _ManageReceiptsPageState extends State<ManageReceiptsPage> {
  @override
  Widget build(BuildContext context) {
    {
      // basic example of retrieving items from global state
      // @TODO: Change to use filtered receipts
      var receipts = Provider.of<ReceiptsProvider>(context).receipts;

      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CameraButton(),
        bottomNavigationBar: FiscoBottomBar(
          children: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)
            ),
            IconButton(icon: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/new')
            ),
          ],
        ),
        body: Container (
          padding: EdgeInsets.symmetric(vertical:32),
          child:Column (
            children : [
              Expanded(
                flex:1,
                child: Container(
                  alignment: Alignment.center,
                  child:Text(
                    "Manage Receipts",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  )
                ),
              ),
              Expanded(
                flex:1,
                child: Container(
                  alignment: Alignment.center,
                  child:DropdownButton(
                    hint: Text('Please choose a data interval'),
                    value: Provider.of<ReceiptsProvider>(context).selectedDataInterval, // any time selected attribute is updated, the dropdown button widget will rebuild
                    onChanged: (value) {
                      Provider.of<ReceiptsProvider>(context, listen: false). // passing false means we don't want to refresh the widget if this next call ever uses notifyListeners
                      selectedDataInterval = value; // normally setters should specify listen false and let the corresponding getters refresh the widget... avoids endless loops
                    },
                    // @TODO: Change to use manageService
                    items: Provider.of<ReceiptsProvider>(context).analysisService.dataInterval.map((item) {
                      return DropdownMenuItem(
                        child: new Text(item),
                        value: item,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded (
                flex:8,
                child:Container(
                  child:ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: receipts.length,
                    itemBuilder: (context, i) {
                      return new ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text (
                              receipts[i].name,
                              style: new TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                            Text (
                              DateFormat('yyyy/MM/dd').format(receipts[i].date),
                              style: new TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                            Text (
                              "Total: " + receipts[i].total.toString() + " \$",
                              style: new TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                          ]
                        ),
                        children: <Widget>[
                          Container(
                            height : 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FlatButton(
                                  color: Colors.indigo,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.blueAccent,
                                  onPressed: () {
                                    //@TODO Edit the current receipt (receipt[i])
                                    Navigator.pushNamed(context, '/edit');
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                                FlatButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.redAccent,
                                  onPressed: () {
                                    setState(() {
                                      receipts.remove(receipts[i]);
                                    });
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ]
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              )
            ]
          )
        )
      );
    }
  }

}