import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/products/products.dart';
import '../widgets/ui_elements/side_drawer.dart';

import '../scoped_models/main.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder:
                  (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            ),
          ],
        ),
        body: Products());
  }

  Widget _buildSideDrawer(BuildContext context) {
    return SideDrawer(
      drawerTitleText: 'Choose',
      listTileText: 'Manage products',
      listTileIcon: Icons.edit,
      listTileIconColor: Colors.grey,
      routeName: '/admin',
      context: context,
    );
  }
}
