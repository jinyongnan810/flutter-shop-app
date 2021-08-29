import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/main_drawer.dart';
import 'package:shop/components/user_product_item.dart';
import 'package:shop/providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static final String routeName = '/user/products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Consumer<Products>(
          builder: (_, products, __) => ListView.builder(
            itemBuilder: (_, index) => Column(
              children: [UserProductItem(products.atIndex(index)), Divider()],
            ),
            itemCount: products.itemCounts,
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
