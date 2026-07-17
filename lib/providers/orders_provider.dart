import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/food.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void placeOrder(Food food, int quantity) {
    _orders.insert(
      0,
      Order(
        food: food,
        quantity: quantity,
        orderedAt: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}