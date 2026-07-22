import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategories(String restaurantId) async {
    try {
      print("========== CATEGORY SERVICE ==========");
      print("Restaurant ID: $restaurantId");

      final snapshot = await _firestore
          .collection("restaurants")
          .doc(restaurantId)
          .collection("categories")
          .get();

      print("Documents found: ${snapshot.docs.length}");

      for (final doc in snapshot.docs) {
        print("Document ID: ${doc.id}");
        print("Data: ${doc.data()}");
      }

      return snapshot.docs
          .map((doc) => Category.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e, stackTrace) {
      print("CATEGORY SERVICE ERROR");
      print(e);
      print(stackTrace);
      return [];
    }
  }
}