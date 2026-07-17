import 'package:flutter/material.dart';

import '../../data/food_data.dart';
import '../../screens/details/food_details_screen.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Featured food (first item = Biryani)
    final featuredFood = foodList.first;

    return Container(
      height: 205,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff2563EB),
            Color(0xff3B82F6),
          ],
        ),
      ),
      child: Row(
        children: [
          /// LEFT
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 12, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "LIMITED OFFER",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "20% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    featuredFood.name,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: 145,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FoodDetailScreen(
                              food: featuredFood,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xff2563EB),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Order Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// RIGHT
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 12,
                top: 12,
                bottom: 12,
              ),
              child: Hero(
                tag: featuredFood.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    featuredFood.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}