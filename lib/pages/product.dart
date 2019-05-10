import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;

  ProductPage({this.title, this.imageUrl, this.description, this.price});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset(imageUrl),
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: new TitleDefault(
                title: title,
              ),
            ),
            _buildAddressPriceRow(),
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: new Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressPriceRow() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          'Parvaz, Tabriz',
          style: TextStyle(color: Colors.grey),
        ),
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        new Text(
          '\$$price',
          style: TextStyle(
            fontFamily: 'OswaldRegular',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

//  _showWarningDialog(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return new AlertDialog(
//          title: Text("Are you sure?"),
//          content: Text("This action cannot be undone!"),
//          actions: <Widget>[
//            new FlatButton(
//              onPressed: () {
//                Navigator.pop(context);
//              },
//              child: Text("DISCARD"),
//            ),
//            new FlatButton(
//              onPressed: () {
//                Navigator.pop(context);
//                Navigator.pop(context, true);
//              },
//              child: Text("DELETE"),
//            ),
//          ],
//        );
//      },
//    );
//  }

}
