import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrderItem extends StatelessWidget {
  final OrderItemInfo orderItem;
  OrderItem(this.orderItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$ ${orderItem.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('yyyy-MM-dd hh:mm:ss').format(orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
