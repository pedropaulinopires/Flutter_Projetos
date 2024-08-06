import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_list_provider.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

Route _createRoute(Widget widget, {bool animatedExecut = true}) {
  return PageRouteBuilder(
    opaque: true,
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = animatedExecut ? const Offset(1, 0) : const Offset(0, 0);
      var end = Offset.zero;
      var curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductListProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderListProvider()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.purple,
            ),
            primaryColor: Colors.purple,
            appBarTheme: const AppBarTheme(
              toolbarHeight: 80,
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Lato')),
        home: const ProductsOverviewPage(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.home) {
            return _createRoute(const ProductsOverviewPage());
          } else if (settings.name == AppRoutes.productDetail) {
            return _createRoute(
                ProductDetailPage(product: settings.arguments as Product),
                animatedExecut: true);
          } else if (settings.name == AppRoutes.cart) {
            return _createRoute(const CartPage());
          } else if (settings.name == AppRoutes.orders) {
            return _createRoute(const OrdersPage());
          } else if (settings.name == AppRoutes.products) {
            return _createRoute(const ProductsPage());
          } else if (settings.name == AppRoutes.productForm) {
            return _createRoute(const ProductFormPage());
          }
          return _createRoute(const ProductsOverviewPage());
        },
      ),
    );
  }
}
