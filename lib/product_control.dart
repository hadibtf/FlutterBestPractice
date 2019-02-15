import 'package:flutter/material.dart';
import './product_manager.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;
  ProductControl(this.addProduct);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        addProduct("Sweets");
      },
      color: Theme.of(context).primaryColor,
      child: new Text("Add Product"),
    );
  }
}
