import 'package:flutter/material.dart';
import './pages/home.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.purple,
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(),
    );
  }
}