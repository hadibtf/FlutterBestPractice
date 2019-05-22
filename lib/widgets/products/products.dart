import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './products_card.dart';
import '../../scoped_models/main.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductsList(model.displayedProducts);
      },
    );
  }

  Widget _buildProductsList(List<Product> products) {
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
}
