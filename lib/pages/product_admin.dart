import 'package:flutter/material.dart';

import './product_edit.dart';
import './products_list.dart';
import '../widgets/ui_elements/side_drawer.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;
  final Function updateProduct;
  final List<Map<String, dynamic>> products;

  ProductsAdminPage({this.addProduct, this.deleteProduct, this.products, this.updateProduct});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: _buildTabBar(),
        ),
        body: _buildTabBarView(),
      ),
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      children: <Widget>[
        ProductsEditPage(
          addProduct: addProduct,
        ),
        ProductListPage(
          products: products,
          updateProduct: updateProduct,
          deleteProduct: deleteProduct,
        ),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(tabs: <Widget>[
      Tab(
        icon: Icon(Icons.list),
        text: "My Product",
      ),
      Tab(
        icon: Icon(Icons.create),
        text: "Create Products",
      ),
    ]);
  }

  Widget _buildSideDrawer(BuildContext context) {
    return SideDrawer(
      drawerTitleText: 'Choose',
      listTileText: 'All products',
      listTileIcon: Icons.shop,
      listTileIconColor: Colors.blue,
      routeName: '/products',
      context: context,
    );
  }
}
