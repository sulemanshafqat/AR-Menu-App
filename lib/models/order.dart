import 'food.dart';

class Order {
  final String id;

  final List<OrderItem> items;

  final String restaurantName;

  final String deliveryAddress;

  final DateTime orderedAt;

  final String paymentMethod;

  final double totalPrice;

  final String status;

  final int estimatedTime;

  // Tracking timestamps
  final DateTime confirmedAt;
  final DateTime acceptedAt;
  final DateTime preparingAt;
  final DateTime? riderAssignedAt;
  final DateTime? outForDeliveryAt;
  final DateTime? deliveredAt;

  // Rider Information
  final String? riderName;
  final String? riderPhone;
  final String? bikeNumber;

  Order({
    required this.id,
    required this.items,
    required this.restaurantName,
    required this.deliveryAddress,
    required this.orderedAt,
    required this.paymentMethod,
    required this.totalPrice,
    required this.status,
    required this.estimatedTime,

    required this.confirmedAt,
    required this.acceptedAt,
    required this.preparingAt,

    this.riderAssignedAt,
    this.outForDeliveryAt,
    this.deliveredAt,

    this.riderName,
    this.riderPhone,
    this.bikeNumber,
  });

  Order copyWith({
    String? status,
    DateTime? riderAssignedAt,
    DateTime? outForDeliveryAt,
    DateTime? deliveredAt,
    String? riderName,
    String? riderPhone,
    String? bikeNumber,
  }) {
    return Order(
      id: id,
      items: items,
      restaurantName: restaurantName,
      deliveryAddress: deliveryAddress,
      orderedAt: orderedAt,
      paymentMethod: paymentMethod,
      totalPrice: totalPrice,
      estimatedTime: estimatedTime,

      confirmedAt: confirmedAt,
      acceptedAt: acceptedAt,
      preparingAt: preparingAt,

      riderAssignedAt:
          riderAssignedAt ?? this.riderAssignedAt,

      outForDeliveryAt:
          outForDeliveryAt ?? this.outForDeliveryAt,

      deliveredAt:
          deliveredAt ?? this.deliveredAt,

      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      bikeNumber: bikeNumber ?? this.bikeNumber,

      status: status ?? this.status,
    );
  }
}

class OrderItem {
  final Food food;
  final int quantity;

  OrderItem({
    required this.food,
    required this.quantity,
  });

  double get total =>
      double.parse(
        food.price.replaceAll("\$", ""),
      ) *
      quantity;
}