import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pages/product_edit.dart';
import '../scoped_models/main.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage({@required this.model});

  @override
  State<StatefulWidget> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth * 0.90;
    final double targetPaddingVertical = (deviceWidth - targetWidth) / 2;

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd ||
                    direction == DismissDirection.endToStart) {
                  model.selectProduct(model.allProducts[index].id);
                  model.deleteProduct();
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
                              fontFamily: 'OswaldSemiBold',
                            ),
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
              key: Key(model.allProducts[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.allProducts[index].image),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle: Text('\$${model.allProducts[index].price}'),
                    trailing: _buildEditIconButton(context, index, model),
                  ),
                  Divider()
                ],
              ));
        },
        itemCount: model.allProducts == null ? 0 : model.allProducts.length,
      );
    });
  }

  Widget _buildEditIconButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ProductsEditPage();
          }),
        ).then(((_) {
          model.selectProduct(null);
        }));
      },
    );
  }
}
