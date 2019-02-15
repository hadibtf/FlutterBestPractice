import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products
          .map(
            (element) => new Card(
                  margin: new EdgeInsets.all(10),
                  elevation: 4.0,
                  child: new Column(
                    children: <Widget>[
                      new Image.asset("images/me.png"),
                      new Text(element)
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}