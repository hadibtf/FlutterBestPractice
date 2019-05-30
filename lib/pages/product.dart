import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../models/product.dart';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage({Key key, this.productIndex});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Product products = model.allProducts[productIndex];
          return Scaffold(
            appBar: AppBar(
              title:  Text(products.title),
            ),
            body:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(products.image),
                Container(
                  padding:  EdgeInsets.all(10.0),
                  child:  TitleDefault(
                    title: products.title,
                  ),
                ),
                _buildAddressPriceRow(products.price.toString()),
                Container(
                  padding:  EdgeInsets.all(10.0),
                  child:  Text(
                    products.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
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

//  _showWarningDialog(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return  AlertDialog(
//          title: Text("Are you sure?"),
//          content: Text("This action cannot be undone!"),
//          actions: <Widget>[
//             FlatButton(
//              onPressed: () {
//                Navigator.pop(context);
//              },
//              child: Text("DISCARD"),
//            ),
//            FlatButton(
//              onPressed: () {
//                Navigator.pop(context);
//                Navigator.pop(context, true);
//              },
//              child: Text("DELETE"),
//            ),
//          ],
//        );
//      },
//    );
//  }

}
