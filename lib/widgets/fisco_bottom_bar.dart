import 'package:flutter/material.dart';

class FiscoBottomBar extends StatelessWidget {

  final children;

  const FiscoBottomBar({
    this.children,
  });


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.teal,
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children ?? []
      ),
    );
  }
}