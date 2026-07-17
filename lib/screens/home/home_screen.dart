import 'package:flutter/material.dart';

import '../../core/widgets/category_chip.dart';
import '../../core/widgets/food_card.dart';
import '../../core/widgets/hero_banner.dart';
import '../../data/food_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "All",
      "Rice",
      "Burger",
      "Pizza",
      "Pasta",
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          children: [
            const Text(
              "Good Evening 👋",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Discover Delicious Food",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const HeroBanner(),

            const SizedBox(height: 28),

            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search dishes...",
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    title: categories[index],
                    selected: index == 0,
                    onTap: () {},
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            ...foodList.map(
              (food) => FoodCard(
                food: food,
              ),
            ),
          ],
        ),
      ),
    );
  }
}