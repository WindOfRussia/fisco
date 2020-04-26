import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/receipts_provider.dart';
import 'providers/ocr_provider.dart';
import 'screens/analysis_page.dart';
import 'screens/intro_slider_screen.dart';
import 'screens/manage_receipts_page.dart';
import 'screens/new_receipt_page.dart';
import 'screens/edit_receipt_page.dart';
import 'screens/display_picture_screen.dart';

//Main method for all Flutter Applications
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ReceiptsProvider>(
        create: (context) => ReceiptsProvider(),
      ),
      ChangeNotifierProvider<OcrProvider>(
        create: (context) => OcrProvider(),
      ),
    ],
    child: Fisco(),
  ));
}

/// This class is the root Widget of the application.
class Fisco extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => IntroScreen(),
        '/new': (context) => NewReceiptPage(),
        '/manage': (context) => ManageReceiptsPage(),
        '/edit': (context) => EditReceiptPage(),
        '/picture': (context) {
          var picture = ModalRoute.of(context).settings.arguments;

          // Access provider instance in stateless widget, run image scan
          Provider.of<OcrProvider>(context, listen: false).scanImage(picture);

          return DisplayPictureScreen(image: picture);
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

