import 'package:flutter/material.dart';
import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _products = [];

  void _addProduct(Map<String, String> product) {
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
//      home: AuthPage(),
      routes: {
        "/": (BuildContext context) => ProductsPage(
            products: _products,
            addProduct: _addProduct,
            deleteProduct: _deleteProduct),
        "/admin": (BuildContext context) => ProductsAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split("/");
        if (pathElements[0] != "") {
          return null;
        }
        if (pathElements[1] == "product") {
          final int index = int.parse(pathElements[2]);
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
          builder: (BuildContext context) => ProductsPage(
              products: _products,
              addProduct: _addProduct,
              deleteProduct: _deleteProduct),
        );
      },
    );
  }
}
