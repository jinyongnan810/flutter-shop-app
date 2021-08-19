import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../components/product_grid_view.dart';

enum FilterOptions { ONLY_FAVORITES, SHOW_ALL }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsState = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                switch (value) {
                  case FilterOptions.ONLY_FAVORITES:
                    productsState.switchShowFavorite(true);
                    break;
                  case FilterOptions.SHOW_ALL:
                    productsState.switchShowFavorite(false);
                    break;
                  default:
                    return;
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Only Favorites"),
                      value: FilterOptions.ONLY_FAVORITES,
                    ),
                    PopupMenuItem(
                      child: Text("Show All"),
                      value: FilterOptions.SHOW_ALL,
                    ),
                  ])
        ],
      ),
      // so that the appBar doesn't need any state to listen
      // extract the part that do need listen state
      body: ProductGridView(),
    );
  }
}
