import 'package:flutter/material.dart';

import '../../screens/home/home_screen.dart';
import '../../screens/orders/orders_screen.dart';
import '../../screens/restaurant/orders_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/profile/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    switch (currentIndex) {
      case 0:
        currentPage = const HomeScreen();
        break;

      case 1:
        currentPage = const OrdersScreen();
        break;

      case 2:
        currentPage = const RestaurantOrdersScreen();
        break;

      case 3:
        currentPage = const CartScreen();
        break;

      case 4:
        currentPage = const ProfileScreen();
        break;

      default:
        currentPage = const HomeScreen();
    }

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: "My Orders",
          ),

          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: "Restaurant",
          ),

          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}