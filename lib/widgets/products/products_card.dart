import 'package:flutter/material.dart';

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
    return new Card(
      child: new Column(
        children: <Widget>[
          new Image.asset(product.image),
          _buildTitlePriceContainer(),
          new AddressTag(
            address: 'Tabriz, Parvaz',
          ),
          _buildActionButtonsButtonBar(context),
        ],
      ),
    );
  }

  ButtonBar _buildActionButtonsButtonBar(BuildContext context) {
    return new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            new IconButton(
              onPressed: () => Navigator.pushNamed<bool>(
                  context, "/product/$productIndex"),
              icon: Icon(
                Icons.info,
                color: Theme.of(context).accentColor,
              ),
            ),
            new IconButton(
              onPressed: () => Navigator.pushNamed<bool>(
                  context, "/product/$productIndex"),
              color: Colors.red,
              icon: new Icon(Icons.favorite_border),
            ),
          ],
        );
  }

  Container _buildTitlePriceContainer() {
    return new Container(
          padding: EdgeInsets.only(top: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TitleDefault(
                title: product.title,
              ),
              new SizedBox(width: 8.0),
              new PriceTag(
                price: product.price.toString(),
              ),
            ],
          ),
        );
  }
}
