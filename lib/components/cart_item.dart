import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItem extends StatelessWidget {
  final CartItemInfo cartItemInfo;
  final String productId;
  CartItem(this.cartItemInfo, this.productId);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemInfo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).remove(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Confirm removing cart item'),
                content: Text("Remove ${cartItemInfo.title} from cart?"),
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
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$ ${cartItemInfo.price}'))),
            ),
            title: Text(cartItemInfo.title),
            subtitle: Text(
                'Total of \$ ${cartItemInfo.price * cartItemInfo.quantity}'),
            trailing: Text('x ${cartItemInfo.quantity}'),
          ),
        ),
      ),
    );
  }
}
