import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/products/products.dart';
import '../widgets/ui_elements/side_drawer.dart';

import '../scoped_models/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage({this.model});

  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Marvel Items'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
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
      body: _buildProductsList(),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No products found!'));
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: model.fetchProducts,
          child: content,
        );
      },
    );
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
