import 'food.dart';

class Order {
  final Food food;
  final int quantity;
  final DateTime orderedAt;

  Order({
    required this.food,
    required this.quantity,
    required this.orderedAt,
  });
}