import 'dart:convert';
import 'dart:developer';

import 'package:book_shopping_cart_app/screens/add_book_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_shopping_cart_app/models/book.dart';
import 'package:book_shopping_cart_app/widgets/book_item.dart';
import 'package:book_shopping_cart_app/screens/cart_screen.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> _func;
  List<Book> fetchedBooks = [];
  List<Book> savedBooks = [];

  @override
  void initState() {
    super.initState();
    _func  = fetchDataFromFirebase();
    // final cartController = Provider.of<CartController>(context, listen: false);
    // savedBooks = cartController.savedBooks;
  }

  Future<List<Book>> fetchDataFromFirebase() async {
    print("asd");
    final url = Uri.https(
      'book-shopping-11554-default-rtdb.firebaseio.com',
      'books.json',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final fetchedBooks = <Book>[];
        data.forEach((key, value) {
          final book = Book(
            id: key,
            title: value['title'],
            price: value['price'].toDouble(),
          );
          fetchedBooks.add(book);
        });
        return fetchedBooks;
      } else {
        print('Failed to fetch books from Firebase. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Failed to fetch books from Firebase. Error: $error');
      return [];
    }
  }
  // void navigateToCartScreen(CartController cartController) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CartScreen(savedBooks: cartController.savedBooks),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    return ChangeNotifierProvider(
      create: (context) => CartController(),
      child: Scaffold(

        appBar: AppBar(
          title: Text('Book Shopping Cart'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white70,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Book>>(
            future: _func,
            builder: (BuildContext ctx,AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return BookItem(
                      book: snapshot.data[index],
                    );
                  },

                );
              }else if(snapshot.hasError){
                return Text("aldaa garlaa");
              }
              else {
                return Center(child: CircularProgressIndicator());
              }
            }
        ),
        floatingActionButton: Consumer<CartController>(
          builder: (context, controller, _) => FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondScreen(),
                ),
              );
              // print("-----$savedBooks");
            },
            label: Text(
              '${controller.totalItems} items - \$${controller.totalPrice.toStringAsFixed(2)}',
            ),
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}

class CartController extends ChangeNotifier {
  List<Book> fetchedBooks = [
    // Book(id: "1", title: "Book1", price: 12.0),
    // Book(id: "2", title: "Book2", price: 12.0),
    // Book(id: "3", title: "Book3", price: 12.0),
    // Book(id: "4", title: "Book4", price: 12.0),
  ];
  List<Book> savedBooks = [];
  // bool isLoading = true;
  // bool hasError = false;
  double totalPrice = 0.0;

  get totalItems {
    return savedBooks.length;
  }


  void calculateTotalPrice() {
    totalPrice = savedBooks.fold(
        0.0, (previousValue, book) => previousValue + book.price);
    notifyListeners();
  }


    addToCart({required Book value}){
    print("object");
      savedBooks.add(value);
    calculateTotalPrice();
      notifyListeners();
    }

  // void addToCart(Book book) {
  //   print("asdasd");
  //   savedBooks.add(book);
  //   notifyListeners();
  //   // if (!savedBooks.contains(book)) {
  //   //   savedBooks.add(book);
  //   //   // calculateTotalPrice();
  //   //   notifyListeners();
  //   //   // print(savedBooks);
  //   // }
  // }


  void removeFromCart(Book book) {
    savedBooks.remove(book);
    fetchedBooks.remove(book);
    notifyListeners();
  }

  void clearCart() {
    savedBooks.clear();
    fetchedBooks.clear();
    notifyListeners();
  }

  bool isBookAdded(String bookId) {
    return savedBooks.any((book) => book.id == bookId);
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    print("adasd");
    return Scaffold(
      body: Consumer<CartController>(
        builder: (context, value, child){
          return Center(child: Text(value.totalPrice.toString()));
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { setState(() {

      }); },

      ),
    );
  }
}
