import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './product_item.dart';

class ProductGridView extends StatelessWidget {
  final onlyFavorite;
  ProductGridView(this.onlyFavorite);
  @override
  Widget build(BuildContext context) {
    // listen for products provider
    final productsState = Provider.of<Products>(context);
    final products =
        this.onlyFavorite ? productsState.itemsFavorite : productsState.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        // its recommended using value when dealing with list items(or existing object)
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            // create: (c) => products[index],
            value: products[index],
            child: ProductItem()));
  }
}
