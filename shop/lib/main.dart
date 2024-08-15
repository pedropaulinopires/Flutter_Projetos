import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/providers/auth_provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_list_provider.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_create_route.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductListProvider>(
          create: (ctx) => ProductListProvider('', '', []),
          update: (context, authProvider, previous) => ProductListProvider(
              authProvider.token ?? '',  authProvider.userId ?? '', previous?.items() ?? []),
        ),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, OrderListProvider>(
          create: (ctx) => OrderListProvider('', '', []),
          update: (context, authProvider, previous) => OrderListProvider(
              authProvider.token ?? '', authProvider.userId ?? '', previous?.items ?? []),
        ),
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
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initial,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.initial) {
            return AppCreateRoute.createRoute(const AuthOrHomePage());
          } else if (settings.name == AppRoutes.auth) {
            return AppCreateRoute.createRoute(const AuthPage());
          } else if (settings.name == AppRoutes.home) {
            return AppCreateRoute.createRoute(const ProductsOverviewPage());
          } else if (settings.name == AppRoutes.productDetail) {
            return AppCreateRoute.createRoute(
                ProductDetailPage(product: settings.arguments as Product),
                animatedExecut: true);
          } else if (settings.name == AppRoutes.cart) {
            return AppCreateRoute.createRoute(const CartPage());
          } else if (settings.name == AppRoutes.orders) {
            return AppCreateRoute.createRoute(const OrdersPage());
          } else if (settings.name == AppRoutes.products) {
            return AppCreateRoute.createRoute(const ProductsPage());
          } else if (settings.name == AppRoutes.productForm) {
            return AppCreateRoute.createRoute(ProductFormPage(
              product: settings.arguments as Product?,
            ));
          }
          return AppCreateRoute.createRoute(const ProductsOverviewPage());
        },
      ),
    );
  }
}
