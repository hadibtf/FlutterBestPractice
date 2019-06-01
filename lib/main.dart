import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/auth.dart';
import './pages/product.dart';
import './pages/product_admin.dart';
import './pages/products.dart';
import './scoped_models/main.dart';
import './models/product.dart';

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
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
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
          "/admin": (BuildContext context) => ProductsAdminPage(model: model),
          "/products": (BuildContext context) => ProductsPage(model: model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split("/");
          if (pathElements[0] != "") {
            return null;
          }
          if (pathElements[1] == "product") {
            final String productId = pathElements[2];
            final Product product = model.allProducts.firstWhere((Product product){
              return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(product: product),
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
