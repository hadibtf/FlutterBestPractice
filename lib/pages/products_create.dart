import 'package:flutter/material.dart';

class ProductsCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new RaisedButton(
        child: Text("Save"),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return new Center(
                child: Text("this is a modal"),
              );
            },
          );
        },
      ),
    );
  }
}
