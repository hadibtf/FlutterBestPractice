import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;

  ProductManager({this.startingProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  @override
  void initState() {
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }
  
  void _deleteProduct(int index){

    setState(() {
      _products.removeAt(index);
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          child: new ProductControl(_addProduct),
        ),
        Expanded(
          child: Products(products: _products, deleteProduct: _deleteProduct),
        )
      ],
    );
  }
}
