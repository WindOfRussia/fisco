import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ocr_provider.dart';
import '../providers/receipts_provider.dart';
import '../widgets/fisco_bottom_bar.dart';

/// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final File image;

  DisplayPictureScreen({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      Navigator.pop(context);
    }

    var ocrActions = Provider.of<OcrProvider>(context, listen: false);
    var receiptsActions = Provider.of<ReceiptsProvider>(context, listen: false);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.refresh),
          onPressed: () {
            ocrActions.scanImage(image);
          }
      ),
      bottomNavigationBar: FiscoBottomBar(
        children: [
          IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)
          ),
          IconButton(icon: Icon(Icons.check),
              onPressed: () {
                receiptsActions.openReceipt(receipt: ocrActions.parseExtractedText());
                Navigator.popAndPushNamed(context, '/new');
              }
          ),
        ],
      ),
      body: (image == null) ? Text('No Image to display') :
      SingleChildScrollView(
        child: Column(
          children: [
            Image.file(image),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 25),
              child: Align(
                child: Consumer<OcrProvider>( // another way of using providers
                  builder: (_, ocr, child) {
                    return Text(ocr?.extractedText ?? 'Processing....');
                  })
              )
            ),
          ]
        ),
      ),
    );
  }
}