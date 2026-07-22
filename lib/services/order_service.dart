import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food.dart';
import '../models/order.dart' as app_models;

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // -----------------------------
  // Place Order
  // -----------------------------
  Future<void> placeOrder({
    required String restaurantId,
    required app_models.Order order,
    required String customerId,
    required String customerName,
    required String customerPhone,
  }) async {
    await _firestore
        .collection("restaurants")
        .doc(restaurantId)
        .collection("orders")
        .doc(order.id)
        .set({
      "customerId": customerId,
      "customerName": customerName,
      "customerPhone": customerPhone,

      "restaurantName": order.restaurantName,
      "deliveryAddress": order.deliveryAddress,

      "paymentMethod": order.paymentMethod,
      "status": order.status,

      "totalPrice": order.totalPrice,
      "estimatedTime": order.estimatedTime,

      "orderedAt": Timestamp.fromDate(order.orderedAt),
      "confirmedAt": Timestamp.fromDate(order.confirmedAt),
      "acceptedAt": Timestamp.fromDate(order.acceptedAt),
      "preparingAt": Timestamp.fromDate(order.preparingAt),

      "riderAssignedAt": order.riderAssignedAt == null
          ? null
          : Timestamp.fromDate(order.riderAssignedAt!),

      "outForDeliveryAt": order.outForDeliveryAt == null
          ? null
          : Timestamp.fromDate(order.outForDeliveryAt!),

      "deliveredAt": order.deliveredAt == null
          ? null
          : Timestamp.fromDate(order.deliveredAt!),

      "riderName": order.riderName,
      "riderPhone": order.riderPhone,
      "bikeNumber": order.bikeNumber,

      "items": order.items.map((item) {
        return {
          "foodId": item.food.id,
          "foodName": item.food.name,
          "price": item.food.price,
          "quantity": item.quantity,
          "image": item.food.image,
        };
      }).toList(),
    });
  }

  // -----------------------------
  // Restaurant Live Orders
  // -----------------------------
  Stream<QuerySnapshot> getRestaurantOrders(
    String restaurantId,
  ) {
    return _firestore
        .collection("restaurants")
        .doc(restaurantId)
        .collection("orders")
        .orderBy("orderedAt", descending: true)
        .snapshots();
  }

  // -----------------------------
  // Update Order Status
  // -----------------------------
  Future<void> updateOrderStatus({
    required String restaurantId,
    required String orderId,
    required String status,
  }) async {
    await _firestore
        .collection("restaurants")
        .doc(restaurantId)
        .collection("orders")
        .doc(orderId)
        .update({
      "status": status,
    });
  }

  // -----------------------------
  // Customer Orders
  // -----------------------------
  // -----------------------------
// Customer Orders (Realtime)
// -----------------------------
Stream<List<app_models.Order>> getOrders(
  String restaurantId,
  String customerId,
) {
  return _firestore
      .collection("restaurants")
      .doc(restaurantId)
      .collection("orders")
      .where("customerId", isEqualTo: customerId)
      .orderBy("orderedAt", descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();

      return app_models.Order(
        id: doc.id,
        restaurantName: data["restaurantName"],
        deliveryAddress: data["deliveryAddress"],
        paymentMethod: data["paymentMethod"],
        totalPrice: (data["totalPrice"] as num).toDouble(),
        status: data["status"],
        estimatedTime: data["estimatedTime"],

        orderedAt:
            (data["orderedAt"] as Timestamp).toDate(),

        confirmedAt:
            (data["confirmedAt"] as Timestamp).toDate(),

        acceptedAt:
            (data["acceptedAt"] as Timestamp).toDate(),

        preparingAt:
            (data["preparingAt"] as Timestamp).toDate(),

        riderAssignedAt: data["riderAssignedAt"] == null
            ? null
            : (data["riderAssignedAt"] as Timestamp).toDate(),

        outForDeliveryAt: data["outForDeliveryAt"] == null
            ? null
            : (data["outForDeliveryAt"] as Timestamp).toDate(),

        deliveredAt: data["deliveredAt"] == null
            ? null
            : (data["deliveredAt"] as Timestamp).toDate(),

        riderName: data["riderName"],
        riderPhone: data["riderPhone"],
        bikeNumber: data["bikeNumber"],

        items: (data["items"] as List).map((item) {
          return app_models.OrderItem(
            quantity: item["quantity"],
            food: Food(
              id: item["foodId"],
              name: item["foodName"],
              description: "",
              image: item["image"],
             price: item["price"].toString(),
              rating: "0",
              category: "",
              arAvailable: false,
            ),
          );
        }).toList(),
      );
    }).toList();
  });
}}