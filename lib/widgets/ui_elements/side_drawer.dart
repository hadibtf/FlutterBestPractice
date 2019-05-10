import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final String drawerTitleText;
  final String listTileText;
  final String routeName;

  final IconData listTileIcon;
  final Color listTileIconColor;

  SideDrawer(
      {this.drawerTitleText,
      this.listTileText,
      this.routeName,
      this.listTileIcon,
      this.listTileIconColor});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Column(
        children: <Widget>[
          new AppBar(
            automaticallyImplyLeading: false,
            title: new Text(drawerTitleText),
          ),
          new ListTile(
            leading: Icon(
              listTileIcon,
              color: listTileIconColor,
            ),
            title: new Text(listTileText),
            onTap: () => Navigator.pushReplacementNamed(context, routeName),
          ),
        ],
      ),
    );
  }
}
