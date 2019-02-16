import 'package:flutter/material.dart';
import './products.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Login'),
        ),
        body: new Center(
          child: new RaisedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => ProductsPage()),
              );
            },
            child: new Text("LOGIN"),
          ),
        )
    );
  }
}
