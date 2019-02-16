import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products({this.products = const [], this.deleteProduct});

  Widget _buildProductsList() {
    Widget productsCards;
    if (products.length > 0) {
      productsCards = new ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } else {
      productsCards =
      new Center(child: new Text('No products found Please add some.'));
    }
    return productsCards;
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return new Card(
      margin: new EdgeInsets.all(10),
      elevation: 4.0,
      child: new Column(
        children: <Widget>[
          new Image.asset(products[index]['image']),
          new Text(products[index]['title']),
          new ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlatButton(
                  onPressed: () =>
                      Navigator
                          .pushNamed<bool  >(context, "/product/$index")
                          .then((bool value) {
                        if (value){
                          deleteProduct(index);
                        }
                        print('=============>$value');
                      }),
                  child: new Text("Details")),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductsList();
  }
}
