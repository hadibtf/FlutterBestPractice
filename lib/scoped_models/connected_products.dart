import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  final String productsRoute =
      'https://marvel-items-black-market.firebaseio.com/products.json';
  final String singleProductsRoute =
      'https://marvel-items-black-market.firebaseio.com/products/';
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  String chocolateImgUrl =
      'https://cdn11.bigcommerce.com/s-zfjwlxfdwk/images/stencil/1280x1280/products/121/522/MK-30-Thors-Hammer-05__93684.1529335574.jpg?c=2&imbypass=on';
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, String image, double price) {
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
    return http.post(productsRoute, body: json.encode(productData)).then(
      (http.Response response) {
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
      },
    );
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) return null;
    return _products[selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };
    return http.put('$singleProductsRoute/${selectedProduct.id}.json',
        body: jsonEncode(updateData)).then((http.Response response) {
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
    _products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (_selProductIndex != null) {
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

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http.get(productsRoute).then(
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
      },
    );
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: 'hadi98', email: email, password: password);
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
