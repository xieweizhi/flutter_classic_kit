import 'package:classic_kit/example/browse.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'MS-Sans-Serif',
        ),
        home: Material(
            child: BrowseWidget()));
  }
}
