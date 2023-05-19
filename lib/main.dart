import 'package:flutter/material.dart';
import 'package:one_app_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:one_app_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:one_app_delivery/src/pages/login/login_page.dart';
import 'package:one_app_delivery/src/pages/register/register_page.dart';
import 'package:one_app_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:one_app_delivery/src/pages/roles/roles_page.dart';
import 'package:one_app_delivery/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App Flutter',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const RegisterPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) =>
            const ClientProductsListPage(),
        'restaurant/orders/list': (BuildContext context) =>
            const RestaurantOrdersListPage(),
        'delivery/orders/list': (BuildContext context) =>
            const DeliveryOrdersListPage(),
      },
      theme: ThemeData(
        fontFamily: 'NimbusSans',
        colorScheme: ColorScheme.light(
          primary: MyColors.primaryColor,
        ),
      ),
    );
  }
}
