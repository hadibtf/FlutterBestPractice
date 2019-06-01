import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  final String productsURL =
      'https://marvel-items-black-market.firebaseio.com/products.json';
  final String singleProductsURL =
      'https://marvel-items-black-market.firebaseio.com/products/';
  final String restApiAuthURL =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyD2FLlJf1yiFP7k7Mbhpj9HibqFtPxyOzI';
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
      'userEmail': _authenticatedUser.id,
      'userId': _authenticatedUser.email
    };
    try {
      final http.Response response =
          await http.post(productsURL, body: json.encode(productData));

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
        .put('$singleProductsURL/${selectedProduct.id}.json',
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
        .delete('$singleProductsURL/${deletedProductId}.json')
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

  void toggleProductFavoriteStatus() {
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
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http.get(productsURL).then(
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
                userId: productData['userId']);
            fetchedProductList.add(product);
          },
        );
        _products = fetchedProductList;
        _isLoading = false;
        notifyListeners();
        _selectedProductId = null;
      },
    );
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: 'hadi98', email: email, password: password);
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    final Map<String, dynamic> authDate = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final http.Response response = await http.post(
      restApiAuthURL,
      body: jsonEncode(authDate),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists!';
    }
    return {'success': !hasError, 'message': message};
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading => _isLoading;
}
