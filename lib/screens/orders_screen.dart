import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/main_drawer.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/providers/orders.dart';

class OrderScreen extends StatefulWidget {
  static final String routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = false;
  Future<void> _load() async {
    setState(() {
      _isLoading = true;
    });
    Future(() async {
      try {
        await Provider.of<Orders>(context, listen: false).load();
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error loading the orders.Please refresh again.'),
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
    final orderState = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => OrderItem(orderState.get(index)),
              itemCount: orderState.orders.length,
            ),
      drawer: MainDrawer(),
    );
  }
}
