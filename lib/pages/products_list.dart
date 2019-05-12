import 'package:flutter/material.dart';

import '../pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;

  ProductListPage({this.products, this.updateProduct});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(products[index]['image']),
              ),
              title: Text(products[index]['title']),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Edit Product'),
                          ),
                          body: ProductsEditPage(
                            product: products[index],
                            updateProduct: updateProduct,
                            productIndex: index,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      itemCount: products.length,
    );
  }
}
