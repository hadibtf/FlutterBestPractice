import 'package:flutter/material.dart';
import './product_manager.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('EasyList'),
        ),
        body:ProductManager("food")
      ),
    );
  }
}