import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../types/page_args.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String routeName = '/product/details';

  @override
  Widget build(BuildContext context) {
    // instead of passing data through one and another constructors, pass id as args
    // and use id to get product data in states
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailArgs;
    final product =
        Provider.of<Products>(context, listen: false).getSingleProduct(args.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text(product.title),
      ),
    );
  }
}
