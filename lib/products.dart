import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
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
      child: new Column(
        children: <Widget>[
          new Image.asset(products[index]['image']),
          new Container(
            padding: EdgeInsets.only(top: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  products[index]['title'],
                  style: TextStyle(fontSize: 26.0, fontFamily: 'OswaldBold'),
                ),
                new SizedBox(width: 8.0),
                new Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: new BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: new Text(
                    '\$${products[index]['price'].toString()}',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            child: new Text('Parvaz, Tabriz'),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          new ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                onPressed: () =>
                    Navigator.pushNamed<bool>(context, "/product/$index"),
                icon: Icon(
                  Icons.info,
                  color: Theme.of(context).accentColor,
                ),
              ),
              new IconButton(
                onPressed: () =>
                    Navigator.pushNamed<bool>(context, "/product/$index"),
                color: Colors.red,
                icon: Icon(Icons.favorite_border),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductsList();
  }
}
