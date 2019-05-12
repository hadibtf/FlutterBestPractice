import 'package:flutter/material.dart';

import '../pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;

  ProductListPage({this.products, this.updateProduct});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetHeight = deviceHeight > 800 ? 720 : deviceHeight * 0.98;
    final double targetPaddingHorizontal = deviceWidth - targetWidth;
    final double targetPaddingVertical = deviceHeight - targetHeight;
    print('W$deviceWidth ------- H$deviceHeight');
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(
            top: targetPaddingVertical / 2,
            left: targetPaddingHorizontal / 2,
            right: targetPaddingHorizontal / 2,
          ),
//          EdgeInsets.symmetric(
//              horizontal: targetPaddingHorizontal / 2,
//              vertical: targetPaddingVertical / 2
//          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: ClipRRect(
                  borderRadius: new BorderRadius.circular(5.0),
                  child: Image.asset(products[index]['image']),
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
              Divider(
                color: Colors.grey,
                height: 2.0,
              )
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
