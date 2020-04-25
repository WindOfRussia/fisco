import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../widgets/fisco_bottom_bar.dart';
import '../widgets/buttons/camera_button.dart';

class ManageReceiptsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    {
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