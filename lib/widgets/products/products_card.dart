import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard({this.product, this.productIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(product.image),
          _buildTitlePriceContainer(),
          AddressTag(address: 'Tabriz, Parvaz'),
          Text(product.userId),
          _buildActionButtonsButtonBar(context),
        ],
      ),
    );
  }

  ButtonBar _buildActionButtonsButtonBar(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () =>
              Navigator.pushNamed<bool>(context, "/product/$productIndex"),
          icon: Icon(
            Icons.info,
            color: Theme.of(context).accentColor,
          ),
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
                onPressed: () {
                  model.selectProduct(productIndex);
                  model.toggleProductFavoriteStatus();
                },
                color: Colors.red,
                icon: model.allProducts[productIndex].isFavorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border));
          },
        ),
      ],
    );
  }

  Container _buildTitlePriceContainer() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(title: product.title),
          SizedBox(width: 8.0),
          PriceTag(price: product.price.toString()),
        ],
      ),
    );
  }
}
