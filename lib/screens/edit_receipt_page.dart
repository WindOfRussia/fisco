import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../widgets/fisco_bottom_bar.dart';

class EditReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.save), onPressed: () {},),
        bottomNavigationBar: FiscoBottomBar(
          children: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: () {},),
          ],
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