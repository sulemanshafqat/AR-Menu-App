import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food.dart';

class MenuService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Food>> getMenu(String restaurantId) async {
    final snapshot = await _firestore
        .collection("restaurants")
        .doc(restaurantId)
        .collection("menu")
        .get();

    return snapshot.docs
        .map(
          (doc) => Food.fromFirestore(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}