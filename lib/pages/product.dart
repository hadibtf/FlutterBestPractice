import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage({this.title, this.imageUrl});

  _showWarningDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("Are you sure?"),
          content: Text("This action cannot be undone!"),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("DISCARD"),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: Text("DELETE"),
            ),
          ],
        );
      },
    );
  }

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
                onPressed: () => _showWarningDialog(context),
                child: new Text("DELETE "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
