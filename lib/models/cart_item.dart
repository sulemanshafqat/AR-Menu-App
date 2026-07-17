import 'food.dart';

class CartItem {
  final Food food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  double get totalPrice {
    final price =
        double.parse(food.price.replaceAll('\$', ''));
    return price * quantity;
  }
}