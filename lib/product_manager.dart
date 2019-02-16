import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {

  final List<Map<String,String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager({Key key, this.products, this.addProduct, this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          child: new ProductControl(addProduct),
        ),
        Expanded(
          child: Products(products: products, deleteProduct: deleteProduct),
        )
      ],
    );
  }
}
