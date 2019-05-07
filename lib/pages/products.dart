import 'package:flutter/material.dart';

import '../product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage({Key key, this.products});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new AppBar(
              automaticallyImplyLeading: false,
              title: new Text("Choose"),
            ),
            new ListTile(
              leading: new Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              title: new Text("Manage Products"),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/admin");
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ProductManager(
        products: products,
      ),
    );
  }
}
