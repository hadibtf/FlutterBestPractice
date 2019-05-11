import 'package:flutter/material.dart';

class ProductsCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductsCreatePage({this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductsCreatePage> {
  String _titleValue;
  String _descriptionValue;
  double _priceValue;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      width: targetWidth,
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextFormField(),
            _buildDescriptionTextFormField(),
            _buildPriceTextFormField(),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              textColor: Colors.white,
              child: Text("Create"),
              onPressed: _submitForm,
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'images/me.png'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, "/products");
  }

  TextFormField _buildTitleTextFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Title"),
      onSaved: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
      validator: (String value) {
//        if (value.trim().length <= 0)
        if (value.isEmpty) {
          return 'Title is required';
        }
      },
    );
  }

  TextFormField _buildDescriptionTextFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Description"),
      maxLines: 4,
      onSaved: (String value) {
        _descriptionValue = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required';
        }
      },
    );
  }

  TextFormField _buildPriceTextFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Price"),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _priceValue = double.parse(value);
      },
      validator: (String value) {
        if (value.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
    );
  }
}
