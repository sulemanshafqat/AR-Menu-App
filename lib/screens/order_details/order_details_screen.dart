import 'package:flutter/material.dart';

import '../../models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Order Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Order #${order.id.substring(order.id.length - 6)}",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    order.restaurantName,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _infoRow(
                    Icons.schedule,
                    "Estimated Delivery",
                    "${order.estimatedTime} mins",
                  ),

                  const Divider(height: 30),

                  _infoRow(
                    Icons.credit_card,
                    "Payment Method",
                    order.paymentMethod,
                  ),

                  const Divider(height: 30),

                  _infoRow(
                    Icons.location_on,
                    "Delivery Address",
                    order.deliveryAddress,
                  ),

                  const Divider(height: 30),

                  _infoRow(
                    Icons.attach_money,
                    "Total",
                    "\$${order.totalPrice.toStringAsFixed(2)}",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Items Ordered",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            ...order.items.map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),

                  child: Row(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.food.image,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              item.food.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(item.food.price),
                          ],
                        ),
                      ),

                      Text(
                        "x${item.quantity}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Order Tracking",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _trackingStep(
              "Order Confirmed",
              true,
            ),

            _trackingStep(
              "Payment Received",
              true,
            ),

            _trackingStep(
              "Preparing Food",
              order.status == "Preparing" ||
                  order.status == "Out for Delivery" ||
                  order.status == "Delivered",
            ),

            _trackingStep(
              "Out for Delivery",
              order.status == "Out for Delivery" ||
                  order.status == "Delivered",
            ),

            _trackingStep(
              "Delivered",
              order.status == "Delivered",
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton.icon(
                onPressed: () {},

                icon: const Icon(Icons.support_agent),

                label: const Text(
                  "Contact Restaurant",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [

        CircleAvatar(
          radius: 20,
          backgroundColor:
              const Color(0xff2563EB).withValues(alpha: .1),

          child: Icon(
            icon,
            color: const Color(0xff2563EB),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _trackingStep(
    String title,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),

      child: Row(
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

              if (title != "Delivered")
                Container(
                  width: 2,
                  height: 35,
                  color: completed
                      ? Colors.green
                      : Colors.grey.shade300,
                ),
            ],
          ),

          const SizedBox(width: 15),

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
      ),
    );
  }
}