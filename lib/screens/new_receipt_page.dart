import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../widgets/fisco_bottom_bar.dart';
import '../models/line_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewReceiptPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewReceiptPageState();
}
/// This is a widget to create a new receipt
class _NewReceiptPageState extends State<NewReceiptPage> {
  List<String> _categories = ['Last Week', 'Last Month', 'Current Week', 'Current Month'];
  String _selectedCategory = 'Last Week';
  // @Todo replace these with values from a receipt object
  var items = [
    LineItem(name: "Item 1", price: 10.00),
    LineItem(name: "Item 2", price: 15.00),
    LineItem(name: "Item 3", price: 5.00),
    LineItem(name: "Item 4", price: 2.50),
  ];
  var TPS = 0.00;
  var TVP = 0.00;
  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.check), onPressed: () {},),
        bottomNavigationBar: FiscoBottomBar(
          children: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)
            ),
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(
                children : [
                  Container(
                      padding: const EdgeInsets.fromLTRB(20.0,50.0,20.0,20.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                      ),
                      child:IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "New Item",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height:50,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Name'
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:50,
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child:TextField(
                                                decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    hintText: 'Date'
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container (
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),

                                                child:DropdownButton(
                                                  hint: Text(""),
                                                  value: _selectedCategory,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selectedCategory = newValue;
                                                    });
                                                  },
                                                  items: _categories.map((location) {
                                                    return DropdownMenuItem(
                                                      child: new Text(location),
                                                      value: location,
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            )
                                          ]
                                      ),
                                    ),
                                    SizedBox(
                                      height:50,
                                      child:TextField(
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'File'
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                      ),
                      child:Column(
                        children: [
                          for(var item in items)
                            IntrinsicHeight(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget> [
                                Expanded(
                                  flex: 5,
                                  child:Container(
                                    height:75,

                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      initialValue: item.name,
                                      onChanged: (text) {
                                        item.name = text;
                                      },
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Item Name'
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                    height:75,

                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: item.price.toString(),
                                      onChanged: (text) {
                                        item.price = double.parse(text);
                                      },
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Price'
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,

                                  child:Container(
                                    alignment: Alignment.centerLeft,
                                    height:75,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "\$"
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                    height:75,
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        color: Colors.red,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                    )
                                  ),
                                ),
                              ]
                            ),
                          ),
                            Container(
                                height:75,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Ink(
                                  decoration: const ShapeDecoration(
                                    color: Colors.indigo,
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                )
                            ),
                          ],
                      ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,50.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                Expanded(
                                  child:Container(
                                    height:75,
                                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child:Container(
                                            alignment: Alignment.topCenter,
                                            child:TextFormField (
                                              keyboardType: TextInputType.number,
                                              initialValue: TPS.toString(),
                                              onChanged: (text) {
                                                TPS = double.parse(text);
                                              },
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  labelText: 'TPS'
                                              ),
                                            ),
                                          )
                                        ),
                                        Expanded (
                                          flex: 3,
                                          child:Container(
                                            alignment: Alignment.center,
                                            child:Text (
                                              "\$"
                                            )
                                          )
                                        ),
                                      ]
                                    )
                                  ),
                                ),
                                Expanded(
                                  child:Container(
                                    height:75,
                                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                        children: [
                                          Expanded(
                                              flex: 7,
                                              child:Container(
                                                alignment: Alignment.topCenter,
                                                child:TextFormField (
                                                  keyboardType: TextInputType.number,
                                                  initialValue: TPS.toString(),
                                                  onChanged: (text) {
                                                    TVP = double.parse(text);
                                                  },
                                                  decoration: InputDecoration(
                                                      border: UnderlineInputBorder(),
                                                      labelText: 'TVP'
                                                  ),
                                                ),
                                              )
                                          ),
                                          Expanded (
                                              flex: 3,
                                              child:Container(
                                                  alignment: Alignment.center,
                                                  child:Text (
                                                      "\$"
                                                  )
                                              )
                                          ),
                                        ]
                                    )
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            height:75,
                            alignment: Alignment.center,
                            child:Column(
                              children: [
                                Text(
                                  "Total:",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  _computeTotal().toString() + " \$",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                  ),
                                )
                              ]
                            )

                          )
                        ]
                      )
                  )
                ]
              )
        ),
      );
    }
  }
  double _computeTotal () {
    double total =0;
    for(var item in items)
      total+= item.price;
    total+= TPS + TVP;
    return total;

  }
}