import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../screens/home_screen.dart';

class BookItem extends StatelessWidget {

  final Book book;

  BookItem({required this.book, });


  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return ListTile(
      title: Text(book.title),
      trailing: IconButton(
        icon: Icon(
          cartController.isBookAdded(book.id)
              ? Icons.check_circle
              : Icons.add_shopping_cart,
        ),
        onPressed: () {
          if (cartController.isBookAdded(book.id)) {
            cartController.removeFromCart(book);
          } else {
            // cartController.addToCart(book);
            Provider.of<CartController>(context, listen: false).addToCart(value: book);
          }
        },
      ),
    );
  }
}
