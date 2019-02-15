import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products([this.products = const []]);

  Widget _buildProductItem(BuildContext context, int index) {
    return new Card(
      margin: new EdgeInsets.all(10),
      elevation: 4.0,
      child: new Column(
        children: <Widget>[
          new Image.asset("images/me.png"),
          new Text(products[index])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );
  }
}
