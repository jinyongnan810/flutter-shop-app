import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrderItem extends StatefulWidget {
  final OrderItemInfo orderItem;
  OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: isExpanded
          ? 100 + min(widget.orderItem.products.length * 20.0 + 50, 180)
          : 100,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$ ${widget.orderItem.amount.toStringAsFixed(2)}'),
              subtitle: Text(DateFormat('yyyy-MM-dd hh:mm:ss')
                  .format(widget.orderItem.dateTime)),
              trailing: IconButton(
                icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              height: isExpanded
                  ? min(widget.orderItem.products.length * 20.0 + 50, 180)
                  : 0,
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                itemBuilder: (ctx, index) => Row(
                  children: [
                    Text(
                      widget.orderItem.products[index].title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      '\$${widget.orderItem.products[index].price} x${widget.orderItem.products[index].quantity}',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
                itemCount: widget.orderItem.products.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
