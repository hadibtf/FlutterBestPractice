import 'package:flutter/material.dart';
import './products.dart';

class ProductsAdminPage extends StatelessWidget {
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
                title: new Text("All Products"),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductsPage()
                    )
                ),
              )
            ],
          ),
        ),
        appBar: new AppBar(
          title: new Text('Manage Products'),
        ),
        body: new Center(
          child: new Text("No products to manage"),
        ));
  }
}
