import 'dart:convert';
import 'package:book_shopping_cart_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddBookScreen extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final url = Uri.https('book-shopping-11554-default-rtdb.firebaseio.com', 'books.json');

  // List<Book> books = [];

  // Future<void> fetchAllProduct() async {
  //   print("------------->ReloadPage");
  //   final url = Uri.https('task-e25a2-default-rtdb.firebaseio.com', '/products.json');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(books.map((book) => book.toJson()).toList()),
  //     );
  //     print(response);
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Id'),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            ElevatedButton(
              onPressed: () {
                // final book = Book(
                //   title: titleController.text,
                //   price: priceController.text,
                // );
                // Navigator.pop(context, book);
                http.post(url,
                    body: json.encode({
                      'id': idController.text,
                      'title': titleController.text ,
                      'price': double.parse(priceController.text)
                    }));
                Navigator.pop(context);
                // fetchAllProduct();
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
