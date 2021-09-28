import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/main_drawer.dart';
import 'package:shop/components/user_product_item.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static final String routeName = '/user/products';
  Future<void> _refreshProducts(BuildContext context) async {
    try {
      await Provider.of<Products>(context, listen: false).loadProducts(true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading the product.Please refresh again.'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Consumer<Products>(
                          builder: (_, products, __) => ListView.builder(
                            itemBuilder: (_, index) => Column(
                              children: [
                                UserProductItem(products.atIndex(index)),
                                Divider()
                              ],
                            ),
                            itemCount: products.itemCounts,
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
