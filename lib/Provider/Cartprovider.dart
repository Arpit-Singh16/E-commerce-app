import 'package:flutter/material.dart';

class cartprovider extends ChangeNotifier {
    List cart = [];
    int itemno = 0;
    int total = 0;
    int price = 0;

  void addtocart(item) {
    cart.add(item);
    // total += item['price'];
    notifyListeners();
  }

  void decrement(item,price) {
    cart.remove(item);
    // total -= price!;
    notifyListeners();
  }

  void clearcart() {
    cart.clear();
    total = 0;
    notifyListeners();
  }
}