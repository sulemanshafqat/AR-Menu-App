import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/restaurant.dart';

class RestaurantService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Restaurant>> getRestaurants() async {
    final snapshot = await _db.collection("restaurants").get();

    return snapshot.docs
        .map(
          (doc) => Restaurant.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }
}