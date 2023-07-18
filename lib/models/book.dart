import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Book extends ChangeNotifier{
  final String id;
  final String title;
  final double price;

  Book({
    required this.id,
    required this.title,
    required this.price,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
    };
  }
}
