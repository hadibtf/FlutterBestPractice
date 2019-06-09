import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import './pages/auth.dart';
import './pages/product.dart';
import './pages/product_admin.dart';
import './pages/products.dart';
import './scoped_models/main.dart';
import './models/product.dart';

void main() {
  MapView.setApiKey('AIzaSyDf2U-_haGFU6N8A44uZw84YKQe224a4NQ');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;
  @override
  void initState() {
    super.initState();
    _model.autoAuth();
    _model.userSubject.listen((bool isAuthenticated){
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
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
          "/": (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsPage(model: _model,),
          "/admin": (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsAdminPage(model: _model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if(!_isAuthenticated) MaterialPageRoute<bool>(
            builder: (BuildContext context) => AuthPage(),
          );
          final List<String> pathElements = settings.name.split("/");
          if (pathElements[0] != "") {
            return null;
          }
          if (pathElements[1] == "product") {
            final String productId = pathElements[2];
            final Product product = _model.allProducts.firstWhere((Product product){
              return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductPage(product: product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsPage(),
          );
        },
      ),
    );
  }
}
