import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager(this.startingProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    _products.add(widget.startingProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          child: new RaisedButton(
            onPressed: () {
              setState(() {
                _products.add("1");
              });
            },
            color: Color.fromARGB(255, 218, 247, 166),
            child: new Text("Add Product"),
          ),
          margin: new EdgeInsets.only(top: 5, bottom: 15),
        ),
        Products(_products)
      ],
    );
  }
}
