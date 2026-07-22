import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class OrdersProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  Future<void> placeOrder({
    required List<CartItem> cartItems,
    required String paymentMethod,
    required double totalPrice,
    required String restaurantName,
    required String deliveryAddress,
    required String customerId,
    required String customerName,
    required String customerPhone,
  }) async {
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

    await _orderService.placeOrder(
      restaurantId: "spectoxr_demo",
      order: order,
      customerId: customerId,
      customerName: customerName,
      customerPhone: customerPhone,
    );

    notifyListeners();
  }
}