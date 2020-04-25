import 'package:flutter/material.dart';
import 'screens/analysis_page.dart';

//Main method for all Flutter Applications
void main() => runApp(MyApp());

/// This class is the root Widget of the application.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AnalysisPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

