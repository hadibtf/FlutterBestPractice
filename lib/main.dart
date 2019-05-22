import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/auth.dart';
import './pages/product.dart';
import './pages/product_admin.dart';
import './pages/products.dart';
import './scoped_models/main.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Color(0xFF000042),
          primaryColor: Color(0xFFAA1428),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF000042),
          ),
        ),
//      home:  AuthPage(),
        routes: {
          "/": (BuildContext context) => AuthPage(),
          "/admin": (BuildContext context) => ProductsAdminPage(),
          "/products": (BuildContext context) => ProductsPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split("/");
          if (pathElements[0] != "") {
            return null;
          }
          if (pathElements[1] == "product") {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductPage(productIndex: index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(),
          );
        },
      ),
    );
  }
}
