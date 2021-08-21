import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../types/page_args.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // listen for product provider
    final product = Provider.of<Product>(context, listen: false);
    // listen for cart provider
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: new ProductDetailArgs(product.id));
            },
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            // partially listen for changes and rebuild
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => product.toggleFavorite(),
                color: Theme.of(context).accentColor,
              ),
              // child is for widgets that need not to rebuild, and can be reference in builder
              // child: Text('Mark as Favorite'),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(cart.items.containsKey(product.id)
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined),
              onPressed: () {
                cart.add(product.id, product.title, product.price);
              },
              color: Theme.of(context).accentColor,
            ),
          )),
    );
  }
}
