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
        // appBar: AppBar(
        //   title: Text(product.title),
        // ),
        body: CustomScrollView(
      slivers: [
        // when scrolled to bottom, the image will became the appbar
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              product.title,
            ),
            background: Hero(
              tag: product.id,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          Text(
            '\$ ${product.price}',
            style: TextStyle(color: Colors.grey, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          SizedBox(
            height: 800,
          )
        ]))
      ],
    ));
  }
}
