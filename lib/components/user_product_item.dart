import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

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
                onPressed: () {},
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
