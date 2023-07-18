import 'package:flutter/material.dart';

import 'home_screen.dart';


class BookShoppingCartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) =>  MaterialApp(
      title: 'Book Shopping Cart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      // home: HomeScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/': (ctx) => HomeScreen(),
      // },
    ),);
  }
}
