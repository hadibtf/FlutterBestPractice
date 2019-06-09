import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import '../models/product.dart';
import '../widgets/form_inputs/location.dart';

class ProductsEditPage extends StatefulWidget {
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                textColor: Colors.white,
                child: Text("Save"),
                onPressed: () => _submitForm(
                      model.addProduct,
                      model.updateProduct,
                      model.selectProduct,
                      model.selectedProductIndex,
                    ),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
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
              _buildTitleTextFormField(product),
              _buildDescriptionTextFormField(product),
              _buildPriceTextFormField(product),
              SizedBox(height: 10.0),
              LocationInput(),
              SizedBox(height: 10.0),
              _buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (selectedProductIndex == -1)
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, "/products")
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ok'),
                    )
                  ],
                );
              });
        }
      });
    else
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, "/products")
          .then((_) => setSelectedProduct(null)));
  }

  Widget _buildTitleTextFormField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionTextFormField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.description,
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

  Widget _buildPriceTextFormField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.price.toString(),
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
