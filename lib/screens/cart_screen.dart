import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {

  // final List<Book> savedBooks;

  const CartScreen({super.key});


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
        actions: [
          TextButton(
            onPressed: () {
              // cartController.clearCart();
            },
            child: Text(
              // 'Buy All - \$${cartController.totalPrice.toStringAsFixed(2)}',
              "",
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<CartController>(
        builder: (context, value, child){
          return Text(value.totalPrice.toString());
        },
      ),
      // body: Consumer<CartController>(
      //   builder: (context, controller, child) {
      //     print(controller.savedBooks.length);
      //     print("cart screen redraw");
      //     return ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: controller.savedBooks.length,
      //       itemBuilder: (context, index) => ListTile(
      //         title: Text(controller.savedBooks[index].title),
      //         subtitle: Text('\$${controller.savedBooks[index].price.toStringAsFixed(2)}'),
      //         trailing: TextButton(
      //           child: const Text(
      //             "Buy",
      //             style: TextStyle(
      //               color: Colors.black54,
      //             ),
      //           ),
      //           onPressed: () {
      //             // cartController.removeFromCart(controller.savedBooks[index]);
      //           },
      //         ),
      //       ),
      //     );
      //   }
      // ),
    );
  }
}
