import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/auth_screen.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/user_products_screen.dart';
import './providers/cart.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // its recommend using create instead of value when creating a new object to provide
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', '', []),
            update: (ctx, auth, previousProducts) => Products(
                auth.token ?? '',
                auth.userId ?? '',
                previousProducts == null ? [] : previousProducts.items)),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders('', '', []),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token ?? '',
                auth.userId ?? '',
                previousOrders == null ? [] : previousOrders.orders)),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : AuthScreen(),
                  future: auth.autoLogin(),
                ),
          routes: {
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
