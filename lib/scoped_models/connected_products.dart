import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../models/auth.dart';

class ConnectedProductsModel extends Model {
  final String productsURL =
      'https://marvel-items-black-market.firebaseio.com/products.json';
  final String apiKey = 'AIzaSyD2FLlJf1yiFP7k7Mbhpj9HibqFtPxyOzI';
  final String singleProductsURL =
      'https://marvel-items-black-market.firebaseio.com/products/';
  final String restApiSignupURL =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyD2FLlJf1yiFP7k7Mbhpj9HibqFtPxyOzI';
  final String restApiSigninURL =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyD2FLlJf1yiFP7k7Mbhpj9HibqFtPxyOzI';
  String _selectedProductId;
  List<Product> _products = [];
  User _authenticatedUser;
  String chocolateImgUrl =
      'https://cdn11.bigcommerce.com/s-zfjwlxfdwk/images/stencil/1280x1280/products/121/522/MK-30-Thors-Hammer-05__93684.1529335574.jpg?c=2&imbypass=on';
  bool _isLoading = false;
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts => List.from(_products);

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  String get selectedProductId => _selectedProductId;

  Product get selectedProduct {
    if (_selectedProductId == null) return null;
    return _products.firstWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  bool get displayFavoritesOnly => _showFavorites;

  int get selectedProductIndex => _products
      .indexWhere((Product product) => product.id == _selectedProductId);

  Future<bool> addProduct(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': chocolateImgUrl,
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    try {
      final http.Response response = await http.post(
          productsURL + '?auth=${_authenticatedUser.token}',
          body: json.encode(productData));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          description: description,
          price: price,
          image: image,
          title: title,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': chocolateImgUrl,
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };
    return http
        .put(
            '$singleProductsURL/${selectedProduct.id}.json?auth=${_authenticatedUser.token}',
            body: jsonEncode(updateData))
        .then(
      (http.Response response) {
        _isLoading = false;
        final Product updateProduct = Product(
            id: selectedProduct.id,
            description: description,
            price: price,
            image: image,
            title: title,
            userEmail: selectedProduct.userEmail,
            userId: selectedProduct.userId);
        _products[selectedProductIndex] = updateProduct;
        notifyListeners();
      },
    );
  }

  void deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    selectProduct(null);
    notifyListeners();
    http
        .delete(
            '$singleProductsURL/${deletedProductId}.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectProduct(String productId) {
    _selectedProductId = productId;
    if (_selectedProductId != null) {
      notifyListeners();
    }
  }

  void toggleProductFavoriteStatus() async {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
      id: selectedProduct.id,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      title: selectedProduct.title,
      isFavorite: newFavoriteStatus,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
    http.Response response;
    if (newFavoriteStatus) {
      response = await http.put(
          '$singleProductsURL${selectedProduct.id}/wishListUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
          body: jsonEncode(true));
    } else {
      response = await http.delete(
          '$singleProductsURL${selectedProduct.id}/wishListUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      final Product updatedProduct = Product(
        id: selectedProduct.id,
        description: selectedProduct.description,
        image: selectedProduct.image,
        price: selectedProduct.price,
        title: selectedProduct.title,
        isFavorite: !newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
      );
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  Future<Null> fetchProducts({onlyForUser = false}) {
    _isLoading = true;
    notifyListeners();
    return http.get(productsURL + '?auth=${_authenticatedUser.token}').then(
      (http.Response response) {
        final List<Product> fetchedProductList = [];
        final Map<String, dynamic> productListData = jsonDecode(response.body);
        if (productListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }
        productListData.forEach(
          (String productId, dynamic productData) {
            final Product product = Product(
              id: productId,
              description: productData['description'],
              price: productData['price'],
              image: productData['image'],
              title: productData['title'],
              userEmail: productData['userEmail'],
              userId: productData['userId'],
              isFavorite: productData['wishListUsers'] == null
                  ? false
                  : (productData['wishListUsers'] as Map<String, dynamic>)
                      .containsKey(_authenticatedUser.id),
            );
            fetchedProductList.add(product);
          },
        );
        _products = onlyForUser ? fetchedProductList.where((Product product) {
                return product.userId == _authenticatedUser.id;}).toList() : fetchedProductList;
        _isLoading = false;
        notifyListeners();
        _selectedProductId = null;
      },
    );
  }
}

class UserModel extends ConnectedProductsModel {
  Timer _authTimer;

  PublishSubject<bool> _userSubject = PublishSubject();

  User get user => _authenticatedUser;

  PublishSubject<bool> get userSubject => _userSubject;

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    http.Response response;

    if (mode == AuthMode.Login) {
      response = await http.post(
        restApiSigninURL,
        body: jsonEncode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        restApiSignupURL,
        body: jsonEncode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
        id: responseData['localId'],
        email: email,
        token: responseData['idToken'],
      );
      setAuthTimeOut(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email was not found!';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found!';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid!';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final DateTime parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.get('userEmail');
      final String userId = prefs.get('userId');
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      final int tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;
      _userSubject.add(true);
      setAuthTimeOut(tokenLifeSpan);
      notifyListeners();
    }
  }

  void logout() async {
    print('LOGOUT----------');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('userEmail');
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
  }

  void setAuthTimeOut(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading => _isLoading;
}
