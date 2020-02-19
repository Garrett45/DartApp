import 'package:flutter/material.dart';
import 'TeamListView.dart';

void main() => runApp(MyApp());

//this is where all of the displayed objects are put
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('2225 Scouting App'),
        ),
        body: Center(
            child: TeamListView()
        ),
      ),
    );
  }
}