import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String address;

  AddressTag({this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      child: new Text(address),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.grey, width: 1.0),
          borderRadius: new BorderRadius.circular(5.0)),
    );
  }
}
