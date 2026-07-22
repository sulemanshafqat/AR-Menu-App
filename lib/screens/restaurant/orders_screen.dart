import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/order_service.dart';

class RestaurantOrdersScreen extends StatelessWidget {
  const RestaurantOrdersScreen({super.key});

  Color statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;

      case "Accepted":
        return Colors.blue;

      case "Preparing":
        return Colors.deepOrange;

      case "Rider Assigned":
        return Colors.purple;

      case "Out for Delivery":
        return Colors.indigo;

      case "Delivered":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  String nextStatus(String status) {
    switch (status) {
      case "Pending":
        return "Accepted";

      case "Accepted":
        return "Preparing";

      case "Preparing":
        return "Rider Assigned";

      case "Rider Assigned":
        return "Out for Delivery";

      case "Out for Delivery":
        return "Delivered";

      default:
        return "Delivered";
    }
  }

  String actionText(String status) {
    switch (status) {
      case "Pending":
        return "Accept Order";

      case "Accepted":
        return "Start Preparing";

      case "Preparing":
        return "Assign Rider";

      case "Rider Assigned":
        return "Send For Delivery";

      case "Out for Delivery":
        return "Mark Delivered";

      case "Delivered":
        return "Completed";

      default:
        return "Update";
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderService orderService = OrderService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Orders"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: orderService.getRestaurantOrders("spectoxr_demo"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Orders Yet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final order = docs[index];
              final data = order.data() as Map<String, dynamic>;

              final String status = data["status"];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Customer
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xff2563EB),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              data["customerName"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(Icons.phone, size: 18),
                          const SizedBox(width: 8),
                          Text(data["customerPhone"]),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(data["deliveryAddress"]),
                          ),
                        ],
                      ),

                      const Divider(height: 28),

                      Row(
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  statusColor(status).withOpacity(.15),
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color: statusColor(status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          const Icon(Icons.payment, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "Payment : ${data["paymentMethod"]}",
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.attach_money, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "Total : Rs ${data["totalPrice"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 28),

                      const Text(
                        "Ordered Items",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...List.generate(
                        (data["items"] as List).length,
                        (i) {
                          final item = data["items"][i];

                          return ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              backgroundColor:
                                  Colors.blue.shade50,
                              child: const Icon(
                                Icons.fastfood,
                                color: Color(0xff2563EB),
                              ),
                            ),
                            title: Text(item["foodName"]),
                            subtitle:
                                Text("Qty : ${item["quantity"]}"),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            status == "Delivered"
                                ? Icons.check_circle
                                : Icons.arrow_forward,
                          ),
                          onPressed: status == "Delivered"
                              ? null
                              : () async {
                                  final newStatus =
                                      nextStatus(status);

                                  await orderService
                                      .updateOrderStatus(
                                    restaurantId:
                                        "spectoxr_demo",
                                    orderId: order.id,
                                    status: newStatus,
                                  );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Order updated to $newStatus",
                                        ),
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xff2563EB),
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),
                          label: Text(
                            actionText(status),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}