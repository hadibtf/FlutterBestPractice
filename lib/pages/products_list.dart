import 'package:flutter/material.dart';

import '../pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage({this.products, this.updateProduct, this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth * 0.90;
    final double targetPaddingVertical = (deviceWidth - targetWidth) / 2;

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible (
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd || direction == DismissDirection.endToStart) {
                deleteProduct(index);
              }
            },
            background: Container(
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: targetPaddingVertical),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OswaldSemiBold'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                      padding: EdgeInsets.only(right: targetPaddingVertical),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OswaldSemiBold'),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ],
              ),
            ),
            key: Key(products[index]['title']),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(products[index]['image']),
                  ),
                  title: Text(products[index]['title']),
                  subtitle: Text('\$${products[index]['price']}'),
                  trailing: _buildEditIconButton(context, index),
                ),
                Divider()
              ],
            ));
      },
      itemCount: products.length,
    );
  }

  IconButton _buildEditIconButton(BuildContext context, int index) {
    return IconButton(
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
    );
  }
}
