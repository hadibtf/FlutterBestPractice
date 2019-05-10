import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  PriceTag({this.price});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: new BoxDecoration(
          color: Theme
              .of(context)
              .accentColor,
          borderRadius: new BorderRadius.circular(5.0)),
      child: new Text(
        '\$$price',
        style: new TextStyle(color: Colors.white),
      ),
    );
  }
}