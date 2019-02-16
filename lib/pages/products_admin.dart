import 'package:flutter/material.dart';
import './products.dart';
import './products_create.dart';
import './products_list.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new AppBar(
                automaticallyImplyLeading: false,
                title: new Text("Choose"),
              ),
              new ListTile(
                title: new Text("All Products"),
                onTap: () => Navigator.pushReplacementNamed(context, "/"),
              ),
            ],
          ),
        ),
        appBar: new AppBar(
          title: new Text('Manage Products'),
          bottom: new TabBar(tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.list),
              text: "My Product",
            ),
            new Tab(
              icon: new Icon(Icons.create),
              text: "Create Products",
            ),
          ]),
        ),
        body: new TabBarView(
          children: <Widget>[
            new ProductsCreatePage(),
            new ProductListPage(),
          ],
        ),
      ),
    );
  }
}
