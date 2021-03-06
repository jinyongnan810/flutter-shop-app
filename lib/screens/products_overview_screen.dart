import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/main_drawer.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/cart_screen.dart';
import '../components/product_grid_view.dart';

enum FilterOptions { ONLY_FAVORITES, SHOW_ALL }

class ProductsOverviewScreen extends StatefulWidget {
  static final String routeName = '/products';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _onlyFavorite = false;
  bool _isLoading = false;
  Future<void> _load() async {
    setState(() {
      _isLoading = true;
    });
    Future(() async {
      try {
        await Provider.of<Products>(context, listen: false).loadProducts();
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error loading the product.Please refresh again.'),
          duration: Duration(seconds: 5),
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                switch (value) {
                  case FilterOptions.ONLY_FAVORITES:
                    setState(() {
                      _onlyFavorite = true;
                    });
                    break;
                  case FilterOptions.SHOW_ALL:
                    setState(() {
                      _onlyFavorite = false;
                    });
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
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch!, value: cart.itemCount.toString()),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      // so that the appBar doesn't need any state to listen
      // extract the part that do need listen state
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              child: ProductGridView(_onlyFavorite), onRefresh: _load),
      drawer: MainDrawer(),
    );
  }
}
