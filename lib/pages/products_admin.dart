import 'package:flutter/material.dart';

import './products_create.dart';
import './products_list.dart';
import '../widgets/ui_elements/side_drawer.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductsAdminPage({this.addProduct, this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: new AppBar(
          title: new Text('Manage Products'),
          bottom: _buildTabBar(),
        ),
        body: _buildTabBarView(),
      ),
    );
  }

  TabBarView _buildTabBarView() {
    return new TabBarView(
      children: <Widget>[
        new ProductsCreatePage(
          addProduct: addProduct,
        ),
        new ProductListPage(),
      ],
    );
  }

  TabBar _buildTabBar() {
    return new TabBar(tabs: <Widget>[
      new Tab(
        icon: new Icon(Icons.list),
        text: "My Product",
      ),
      new Tab(
        icon: new Icon(Icons.create),
        text: "Create Products",
      ),
    ]);
  }

  Widget _buildSideDrawer(BuildContext context) {
    return new SideDrawer(
      drawerTitleText: 'Choose',
      listTileText: 'All products',
      listTileIcon: Icons.shop,
      listTileIconColor: Colors.blue,
      routeName: '/products',
      context: context,
    );
  }
}
