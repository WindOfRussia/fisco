import 'package:fiscoapp/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../globals.dart' as globals;
import '../providers/receipts_provider.dart';
import '../widgets/fisco_bottom_bar.dart';
import '../widgets/buttons/camera_button.dart';

class ManageReceiptsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    {
      // basic example of retrieving items from global state
      var receipts = Provider.of<ReceiptsProvider>(context).receipts;
      receipts.add(new Receipt(total: 45.40));

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