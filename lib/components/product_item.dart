import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../types/page_args.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // listen for product provider
    final product = Provider.of<Product>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: new ProductDetailArgs(product.id));
              },
              child: Hero(
                tag: product.id,
                child: FadeInImage(
                  image: NetworkImage(product.image),
                  placeholder:
                      AssetImage('assets/images/product-placeholder.png'),
                  fit: BoxFit.cover,
                ),
              )),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            // partially listen for changes and rebuild
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () async {
                  try {
                    await product.toggleFavorite(
                        auth.token ?? '', auth.userId ?? '');
                  } catch (error) {
                    print(error);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Error favoriting the product.Please try again later.'),
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
                color: Theme.of(context).accentColor,
              ),
              // child is for widgets that need not to rebuild, and can be reference in builder
              // child: Text('Mark as Favorite'),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: Consumer<Cart>(
                builder: (_, cart, __) => IconButton(
                      icon: Icon(cart.items.containsKey(product.id)
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined),
                      onPressed: () {
                        cart.add(product.id, product.title, product.price);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Added ${product.title} to the cart.(Now ${cart.productQuantity(product.id)} of them)'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.undoAdd(product.id);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Undid adding ${product.title} to the cart.(Now ${cart.productQuantity(product.id)} of them)'),
                                  duration: Duration(seconds: 2)));
                            },
                          ),
                        ));
                      },
                      color: Theme.of(context).accentColor,
                    )),
          )),
    );
  }
}
