import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 30,

      splashColor: Colors.blue,
      onPressed: () {
        addProduct({'title': 'chocolate', 'image': './images/me.png'});
      },
      color: Theme.of(context).primaryColor,
      child: new Text("Add Product"),
    );
  }
}
