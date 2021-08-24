import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/providers/orders.dart';

class OrderScreen extends StatelessWidget {
  static final String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderState = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderItem(orderState.get(index)),
        itemCount: orderState.orders.length,
      ),
    );
  }
}
