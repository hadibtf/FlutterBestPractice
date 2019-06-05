import 'package:flutter/material.dart';

import './product_edit.dart';
import './products_list.dart';
import '../widgets/ui_elements/side_drawer.dart';
import '../scoped_models/main.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage({this.model});

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
        ProductsEditPage(),
        ProductListPage(model: model),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(tabs: <Widget>[
      Tab(
        icon: Icon(Icons.create),
        text: "Create Products",
      ),
      Tab(
        icon: Icon(Icons.list),
        text: "My Product",
      ),
    ]);
  }

  Widget _buildSideDrawer(BuildContext context) {
    return SideDrawer(
      drawerTitleText: 'Choose',
      listTileText: 'All products',
      listTileIcon: Icons.shop,
      listTileIconColor: Colors.blue,
      routeName: '/',
    );
  }
}
