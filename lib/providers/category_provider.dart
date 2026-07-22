import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<Category> _categories = [];

  bool _loading = false;

  List<Category> get categories => _categories;

  bool get loading => _loading;

  Future<void> loadCategories() async {
    print("CATEGORY PROVIDER CALLED");

    _loading = true;
    notifyListeners();

    _categories =
        await _categoryService.getCategories("spectoxr_demo");

    print("Loaded ${_categories.length} categories");

    _loading = false;
    notifyListeners();
  }
}