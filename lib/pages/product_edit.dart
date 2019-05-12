import 'package:flutter/material.dart';

class ProductsEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductsEditPage(
      {this.addProduct, this.product, this.updateProduct, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductsEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'images/me.png'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
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
                child: Text("Save"),
                onPressed: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (widget.product == null)
      widget.addProduct(_formData);
    else
      widget.updateProduct(_formData, widget.productIndex);
    Navigator.pushReplacementNamed(context, "/products");
  }

  TextFormField _buildTitleTextFormField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product['title'],
      decoration: InputDecoration(labelText: "Product Title"),
      onSaved: (String value) {
        _formData['title'] = value;
      },
      validator: (String value) {
//        if (value.trim().length <= 0)
        if (value.isEmpty) {
          return 'Title is required.';
        }
      },
    );
  }

  TextFormField _buildDescriptionTextFormField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product['description'],
      decoration: InputDecoration(labelText: "Product Description"),
      maxLines: 4,
      onSaved: (String value) {
        _formData['description'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required.';
        }
      },
    );
  }

  TextFormField _buildPriceTextFormField() {
    return TextFormField(
      initialValue:
          widget.product == null ? '' : widget.product['price'].toString(),
      decoration: InputDecoration(labelText: "Product Price"),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is required.';
        }
      },
    );
  }
}
