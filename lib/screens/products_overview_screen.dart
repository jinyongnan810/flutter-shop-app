import 'package:flutter/material.dart';
import '../components/product_grid_view.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      // so that the appBar doesn't need any state to listen
      // extract the part that do need listen state
      body: ProductGridView(),
    );
  }
}
