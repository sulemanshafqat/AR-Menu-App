import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> _activeOrders = [];
  final List<Order> _history = [];

  List<Order> get activeOrders => _activeOrders;

  List<Order> get history => _history;

  void placeOrder({
    required List<CartItem> cartItems,
    required String paymentMethod,
    required double totalPrice,
    String restaurantName = "Specto Restaurant",
    String deliveryAddress = "Current Address",
  }) {
    final now = DateTime.now();

    final order = Order(
      id: now.millisecondsSinceEpoch.toString(),

      items: cartItems
          .map(
            (item) => OrderItem(
              food: item.food,
              quantity: item.quantity,
            ),
          )
          .toList(),

      restaurantName: restaurantName,
      deliveryAddress: deliveryAddress,
      orderedAt: now,
      paymentMethod: paymentMethod,
      totalPrice: totalPrice,

      status: "Pending",

      estimatedTime: 30,

      confirmedAt: now,
      acceptedAt: now,
      preparingAt: now,

      riderAssignedAt: null,
      outForDeliveryAt: null,
      deliveredAt: null,

      riderName: null,
      riderPhone: null,
      bikeNumber: null,
    );

    _activeOrders.insert(0, order);

    notifyListeners();
  }

  void updateStatus(Order order, String newStatus) {
    final index =
        _activeOrders.indexWhere((o) => o.id == order.id);

    if (index == -1) return;

    final now = DateTime.now();

    Order updated = order.copyWith(
      status: newStatus,
    );

    switch (newStatus) {
      case "Rider Assigned":
        updated = updated.copyWith(
          riderAssignedAt: now,
          riderName: "Ali Ahmed",
          riderPhone: "+92 301 9876543",
          bikeNumber: "LEA-2456",
        );
        break;

      case "Out for Delivery":
        updated = updated.copyWith(
          outForDeliveryAt: now,
        );
        break;

      case "Delivered":
        updated = updated.copyWith(
          deliveredAt: now,
        );
        break;
    }

    _activeOrders[index] = updated;

    notifyListeners();
  }

  void markDelivered(Order order) {
    _activeOrders.removeWhere(
      (o) => o.id == order.id,
    );

    final deliveredOrder = order.copyWith(
      status: "Delivered",
      deliveredAt: DateTime.now(),
    );

    _history.insert(
      0,
      deliveredOrder,
    );

    notifyListeners();
  }
}