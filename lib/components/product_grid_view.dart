import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './product_item.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // listen for products provider
    final productsState = Provider.of<Products>(context);
    final products = productsState.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, index) => ProductItem(products[index]));
  }
}
