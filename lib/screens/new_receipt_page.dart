
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class NewReceiptPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewReceiptPageState();
}
/// This is a widget to create a new receipt
class _NewReceiptPageState extends State<NewReceiptPage> {
  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.check), onPressed: () {},),
        bottomNavigationBar: BottomAppBar(
          color: Colors.teal,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
        ),
      );
    }
  }

}