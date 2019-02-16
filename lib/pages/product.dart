import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("===========================>back bt pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset(imageUrl),
            new Container(
                padding: new EdgeInsets.all(10.0), child: new Text("Details!")),
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: new RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pop(context, true),
                child: new Text("DELETE "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
