import 'package:flutter/material.dart';

class ProductsCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductsCreatePage({this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return new _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductsCreatePage> {
  String titleValue;
  String descriptionValue;
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10.0),
      child: new ListView(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(labelText: "Product Title"),
            onChanged: (String value) {
              setState(() {
                titleValue = value;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(labelText: "Product Description"),
            maxLines: 4,
            onChanged: (String value) {
              setState(() {
                descriptionValue = value;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(labelText: "Product Price"),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                priceValue = double.parse(value);
              });
            },
          ),
          new SizedBox(height: 10.0,),
          new RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: new Text("Create"),
            onPressed: () {
              final Map<String, dynamic> product = {
                'title': titleValue,
                'description': descriptionValue,
                'price': priceValue,
                'image': 'images/me.png'
              };
              widget.addProduct(product);
              Navigator.pushReplacementNamed(context, "/");
            },
          )
        ],
      ),
    );
  }
}
