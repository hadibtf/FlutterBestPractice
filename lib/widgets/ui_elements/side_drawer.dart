import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';

class SideDrawer extends StatelessWidget {
  final String drawerTitleText;
  final String listTileText;
  final String routeName;
  final IconData listTileIcon;
  final Color listTileIconColor;

  SideDrawer({
    this.drawerTitleText,
    this.listTileText,
    this.routeName,
    this.listTileIcon,
    this.listTileIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text(drawerTitleText),
              ),
              ListTile(
                leading: Icon(
                  listTileIcon,
                  color: listTileIconColor,
                ),
                title: Text(listTileText),
                onTap: () => Navigator.pushReplacementNamed(context, routeName),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () => model.logout(),
              )
            ],
          ),
        );
      },
    );
  }
}
