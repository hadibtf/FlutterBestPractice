import 'package:flutter/material.dart';
import './product_manager.dart';

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
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('EasyList'),
        ),
        body:ProductManager()
      ),
    );
  }
}