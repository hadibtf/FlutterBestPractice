import 'package:flutter/material.dart';
import '../product_manager.dart';

class ProductsPage extends StatelessWidget {
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
                title: new Text("Manage Products"),
                onTap: () {},
              )
            ],
          ),
        ),
        appBar: new AppBar(
          title: new Text('EasyList'),
        ),
        body: ProductManager());
  }
}
