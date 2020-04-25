
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'widgets/buttons/CameraButton.dart';

class ManageReceiptsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageReceiptsPageState();
}
/// This is a widget to create a new receipt
class _ManageReceiptsPageState extends State<ManageReceiptsPage> {
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
              IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                  Navigator.pop(context);
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

            ],
          ),
        ),
      );
    }
  }

}