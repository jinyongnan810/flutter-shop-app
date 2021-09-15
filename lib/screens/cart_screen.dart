import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/orders_screen.dart';

class CartScreen extends StatelessWidget {
  static final routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 20),
                  ),
                  // split widgets sections
                  Spacer(),
                  // chip is a pill-like container
                  Chip(
                    label: Text(
                      '\$ ${cart.total.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                      onPressed: cart.total <= 0
                          // when onPressed is null, the button will be disabled
                          ? null
                          : () {
                              Provider.of<Orders>(context, listen: false)
                                  .add(cart.itemsList, cart.total);
                              cart.clear();
                              Navigator.of(context)
                                  .pushReplacementNamed(OrderScreen.routeName);
                            },
                      child: Text('Order Now'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) =>
                CartItem(cart.get(cart.keys[i])!, cart.keys[i]),
            itemCount: cart.productCount,
          )),
        ],
      ),
    );
  }
}
