import 'package:flutter/material.dart';

import '../../models/food.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Food food;

  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// IMAGE
              Stack(
                children: [

                  Hero(
                    tag: widget.food.name,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        widget.food.image,
                        width: double.infinity,
                        height: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 18,
                    left: 18,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [

                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          widget.food.rating,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          widget.food.price,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xff2563EB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      widget.food.description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [

                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove_circle),
                          iconSize: 34,
                          color: Colors.red,
                        ),

                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add_circle),
                          iconSize: 34,
                          color: Colors.green,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton.icon(
                        onPressed: () {},

                        icon: const Icon(Icons.view_in_ar),

                        label: const Text(
                          "View in AR",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2563EB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: OutlinedButton.icon(
                        onPressed: () {},

                        icon: const Icon(Icons.shopping_cart),

                        label: const Text(
                          "Add To Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xff2563EB),
                          side: const BorderSide(
                            color: Color(0xff2563EB),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}