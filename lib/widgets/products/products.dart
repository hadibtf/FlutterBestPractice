import 'package:flutter/material.dart';

import './products_card.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {
  final List<Product> products;
  final Function deleteProduct;

  Products({this.products = const [], this.deleteProduct});

  Widget _buildProductsList() {
    Widget productsCards;
    if (products.length > 0) {
      productsCards = new ListView.builder(
        itemBuilder: (BuildContext context, int index) => new ProductCard(
              product: products[index],
              productIndex: index,
            ),
        itemCount: products.length,
      );
    } else {
      productsCards =
          new Center(child: new Text('No products found Please add some.'));
    }
    return productsCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductsList();
  }
}
