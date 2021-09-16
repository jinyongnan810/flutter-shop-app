import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/main_drawer.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/providers/orders.dart';

class OrderScreen extends StatelessWidget {
  static final String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    // final orderState = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).load(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.hasError) {
              print(dataSnapshot.error);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error loading the orders.Please refresh again.'),
                duration: Duration(seconds: 5),
              ));
            }
            return Consumer<Orders>(builder: (ctx, orderState, child) {
              return ListView.builder(
                itemBuilder: (ctx, index) => OrderItem(orderState.get(index)),
                itemCount: orderState.orders.length,
              );
            });
          }
        },
      ),
      drawer: MainDrawer(),
    );
  }
}
