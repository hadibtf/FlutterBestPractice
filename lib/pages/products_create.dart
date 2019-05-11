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
  String _titleValue;
  String _descriptionValue;
  double _priceValue;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return new Container(
      width: targetWidth,
      margin: EdgeInsets.all(10.0),
      child: new ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          new SizedBox(
            height: 10.0,
          ),
          new RaisedButton(
            textColor: Colors.white,
            child: new Text("Create"),
            onPressed: _submitForm,
          )
        ],
      ),
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'images/me.png'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, "/products");
  }

  Widget _buildTitleTextField() {
    return new TextField(
      decoration: new InputDecoration(labelText: "Product Title"),
      onChanged: (String value) {
        setState(
          () {
            _titleValue = value;
          },
        );
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return new TextField(
      decoration: new InputDecoration(labelText: "Product Description"),
      maxLines: 4,
      onChanged: (String value) {
        setState(
          () {
            _descriptionValue = value;
          },
        );
      },
    );
  }

  Widget _buildPriceTextField() {
    return new TextField(
      decoration: new InputDecoration(labelText: "Product Price"),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        setState(
          () {
            _priceValue = double.parse(value);
          },
        );
      },
    );
  }
}
