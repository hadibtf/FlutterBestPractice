import 'dart:async';

import 'package:flutter/material.dart';
import '../models/product.dart';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage({Key key, this.product});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title:  Text(product.title),
        ),
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
                placeholder: AssetImage('images/avengers.jpg'),
                image: NetworkImage(product.image)),
            Container(
              padding:  EdgeInsets.all(10.0),
              child:  TitleDefault(
                title: product.title,
              ),
            ),
            _buildAddressPriceRow(product.price.toString()),
            Container(
              padding:  EdgeInsets.all(10.0),
              child:  Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildAddressPriceRow(String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Parvaz, Tabriz',
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$$price',
          style: TextStyle(
            fontFamily: 'OswaldRegular',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
