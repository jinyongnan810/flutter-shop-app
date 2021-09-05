import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/types/page_args.dart';

class UserProductItem extends StatelessWidget {
  final Product _product;
  UserProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.image),
      ),
      trailing: Container(
        width: 100,
        // row will take all width, there have to be a parent widget to restrict its width
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: EditUserProductArgs(_product.id));
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: () async {
                bool confirmed = await showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text('Confirm removing product'),
                        content: Text("Remove ${_product.title}?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text('No')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                              child: Text('Yes')),
                        ],
                      );
                    });
                if (confirmed) {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(_product.id);
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
