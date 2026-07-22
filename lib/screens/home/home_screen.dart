import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/category_chip.dart';
import '../../core/widgets/food_card.dart';
import '../../core/widgets/hero_banner.dart';

import '../../providers/menu_provider.dart';
import '../../providers/category_provider.dart';

import '../favorites/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MenuProvider>().loadMenu();
      context.read<CategoryProvider>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    print("Categories count: ${categoryProvider.categories.length}");

for (final c in categoryProvider.categories) {
  print("${c.id} - ${c.name}");
}

    final categories = [
      "All",
      ...categoryProvider.categories.map((e) => e.name),
    ];

    final filteredFood = menuProvider.menu.where((food) {
      final matchesSearch = food.name
          .toLowerCase()
          .contains(searchText.toLowerCase());

      final matchesCategory = selectedCategory == "All" ||
          food.category.toLowerCase() ==
              selectedCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: menuProvider.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                children: [
                  /// Top Row
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening 👋",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Discover Delicious Food",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const FavoritesScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const HeroBanner(),

                  const SizedBox(height: 28),

                  /// Search
                  Container(
                    height: 46,
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
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search dishes...",
                        contentPadding:
                            EdgeInsets.only(bottom: 10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Categories
                  SizedBox(
                    height: 48,
                    child: categoryProvider.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              return CategoryChip(
                                title: categories[index],
                                selected:
                                    selectedCategory ==
                                        categories[index],
                                onTap: () {
                                  setState(() {
                                    selectedCategory =
                                        categories[index];
                                  });
                                },
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 30),

                  if (filteredFood.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "No dishes found",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  else
                    ...filteredFood.map(
                      (food) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 24),
                        child: FoodCard(food: food),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}