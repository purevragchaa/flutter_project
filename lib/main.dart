import 'package:book_shopping_cart_app/screens/book_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_shopping_cart_app/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartController(),
      builder: (context, child) => BookShoppingCartApp(),
      // child: BookShoppingCartApp(),
    ),
  );
}


