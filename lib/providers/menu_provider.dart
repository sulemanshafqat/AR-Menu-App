import 'package:flutter/material.dart';

import '../models/food.dart';
import '../services/menu_service.dart';

class MenuProvider extends ChangeNotifier {
  final MenuService _menuService = MenuService();

  List<Food> _menu = [];

  bool _loading = false;

  List<Food> get menu => _menu;

  bool get loading => _loading;

  Future<void> loadMenu() async {
    _loading = true;
    notifyListeners();

    _menu = await _menuService.getMenu("spectoxr_demo");

    _loading = false;
    notifyListeners();
  }
}