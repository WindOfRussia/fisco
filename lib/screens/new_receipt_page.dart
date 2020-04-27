import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/receipts_provider.dart';
import '../widgets/fisco_bottom_bar.dart';
import '../models/line_item.dart';
import '../models/receipt.dart';

/// This is a widget to create a new receipt
class NewReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    {
      var actions = Provider.of<ReceiptsProvider>(context, listen: false);
      Receipt receipt = Provider.of<ReceiptsProvider>(context).currentReceipt;

      if (receipt == null) { // Dumbass proofing myself
        return Text('Loading...');
      }

      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.check),
          onPressed: () {
            actions.saveOpenReceipt(receipt: receipt);
            Navigator.pop(context);
          },
        ),
        bottomNavigationBar: FiscoBottomBar(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  actions.closeReceipt();
                  Navigator.pop(context);
                }),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor))),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New Receipt",
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                initialValue: receipt.name,
                                onChanged: (text) {
                                  receipt.name = text;
                                  actions.updateOpenReceipt(receipt);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Name'),
                              ),
                            ),
                            SizedBox(
                              height: 75,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Date',
                                              hintText: 'YYYY/MM/DD'),
                                          initialValue: DateFormat('yyyy/MM/dd').format(receipt.date),
                                          onChanged: (text) {
                                            receipt.date = DateFormat("YYYY/MM/DD").parse(text);
                                            actions.updateOpenReceipt(receipt);
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ]),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: DropdownButton<Categories>(
                                          hint: Text(""),
                                          value: receipt.category,
                                          onChanged: (Categories cat) {
                                            receipt.category = cat;
                                            actions.updateOpenReceipt(receipt);
                                          },
                                          items: Categories.values
                                              .map((Categories cat) {
                                            return DropdownMenuItem<Categories>(
                                              child: Text(cat
                                                  .toString()
                                                  .split('.')
                                                  .last),
                                              value: cat,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 75,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'File'),
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              )),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor))),
            child: Column(
              children: [
                for (var item in receipt.items)
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 75,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                initialValue: item.name,
                                onChanged: (text) {
                                  item.name = text;
                                  actions.updateOpenReceipt(receipt);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Item Name'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 75,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: item.price.toString(),
                                onChanged: (text) {
                                  item.price = double.parse(text);
                                  actions.updateOpenReceipt(receipt);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Price'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 75,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("\$"),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                                height: 75,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Ink(
                                  decoration: const ShapeDecoration(
                                    color: Colors.red,
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    color: Colors.white,
                                    onPressed: () {
                                      receipt.items.remove(item);
                                      actions.updateOpenReceipt(receipt);
                                    },
                                  ),
                                )),
                          ),
                        ]),
                  ),
                Container(
                    height: 75,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.indigo,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {
                          receipt.items.add(LineItem(
                              name: "Item " +
                                  (receipt.items.length + 1).toString(),
                              price: 0));
                          actions.updateOpenReceipt(receipt);
                        },
                      ),
                    )),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                height: 75,
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Row(children: [
                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: receipt.tps.toString(),
                                          onChanged: (text) {
                                            receipt.tps = double.parse(text);
                                            actions.updateOpenReceipt(receipt);
                                          },
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'TPS'),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text("\$"))),
                                ])),
                          ),
                          Expanded(
                            child: Container(
                                height: 75,
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Row(children: [
                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: receipt.tvp.toString(),
                                          onChanged: (text) {
                                            receipt.tvp = double.parse(text);
                                            actions.updateOpenReceipt(receipt);
                                          },
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'TVP'),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text("\$"))),
                                ])),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 75,
                        alignment: Alignment.center,
                        child: Column(children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(receipt.total.toString() + " \$",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        ]))
                  ]))
        ])),
      );
    }
  }
}