import 'package:flutter/material.dart';

import '../widgets/products/products.dart';
import '../widgets/ui_elements/side_drawer.dart';
import '../models/product.dart';
class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage({Key key, this.products});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: _buildSideDrawer(context),
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
        body: Products(products: products));
  }

  Widget _buildSideDrawer(BuildContext context) {
    return new SideDrawer(
      drawerTitleText: 'Choose',
      listTileText: 'Manage products',
      listTileIcon: Icons.edit,
      listTileIconColor: Colors.grey,
      routeName: '/admin',
      context: context,
    );
  }
}
