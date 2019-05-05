import 'package:flutter/material.dart';

import './pages/product.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.purple,
        primarySwatch: Colors.deepOrange,
      ),
//      home: new AuthPage(),
      routes: {
        "/": (BuildContext context) => new AuthPage(),
        "/products": (BuildContext context) => new ProductsPage(products: _products),
        "/admin": (BuildContext context) => new ProductsAdminPage(
            addProduct: _addProduct, deleteProduct: _deleteProduct),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split("/");
        if (pathElements[0] != "") {
          return null;
        }
        if (pathElements[1] == "product") {
          final int index = int.parse(pathElements[2]);
          print("()-()-()-()-()-()-()-()-()-()-()-()" + settings.toString());
          return new MaterialPageRoute<bool>(
            builder: (BuildContext context) => new ProductPage(
                  title: _products[index]["title"],
                  imageUrl: _products[index]["image"],
                ),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return new MaterialPageRoute(
          builder: (BuildContext context) => new ProductsPage(
                products: _products,
              ),
        );
      },
    );
  }
}
