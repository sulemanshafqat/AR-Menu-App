import 'package:flutter/material.dart';

import '../../models/order.dart';

class OrderTrackingScreen extends StatelessWidget {
  final Order order;

  const OrderTrackingScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Track Order"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [

                    Row(
                      children: [

                        const Icon(
                          Icons.restaurant,
                          color: Color(0xff2563EB),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            order.restaurantName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [

                        const Icon(Icons.location_on),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(order.deliveryAddress),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [

                        const Icon(Icons.schedule),

                        const SizedBox(width: 10),

                        Text(
                          "${order.estimatedTime} mins",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Order Status",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView(
                children: [

                  _step(
                    "Order Confirmed",
                    true,
                  ),

                  _step(
                    "Restaurant Accepted",
                    true,
                  ),

                  _step(
                    "Preparing Food",
                    true,
                  ),

                  _step(
                    "Rider Picked Up",
                    order.status != "Preparing",
                  ),

                  _step(
                    "On The Way",
                    order.status == "Out for Delivery" ||
                        order.status == "Delivered",
                  ),

                  _step(
                    "Delivered",
                    order.status == "Delivered",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(
    String title,
    bool completed,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Column(
          children: [

            Icon(
              completed
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: completed
                  ? Colors.green
                  : Colors.grey,
            ),

            Container(
              width: 2,
              height: 50,
              color: Colors.grey.shade300,
            ),
          ],
        ),

        const SizedBox(width: 16),

        Padding(
          padding: const EdgeInsets.only(top: 2),

          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: completed
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}