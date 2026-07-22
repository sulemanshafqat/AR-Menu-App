import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../../providers/auth_provider.dart';
import '../../services/order_service.dart';
import '../order_tracking/order_tracking_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Please login first"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xff2563EB),
          labelColor: const Color(0xff2563EB),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Current"),
            Tab(text: "History"),
          ],
        ),
      ),

      body: StreamBuilder<List<Order>>(
        stream: _orderService.getOrders(
          "spectoxr_demo",
          auth.user!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        if (snapshot.hasError) {
  return Center(
    child: Text(
      snapshot.error.toString(),
      textAlign: TextAlign.center,
    ),
  );
}

if (!snapshot.hasData) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

          final allOrders = snapshot.data!;

       final activeOrders = allOrders
    .where((o) => o.status != "Delivered")
    .toList();

final historyOrders = allOrders
    .where((o) => o.status == "Delivered")
    .toList();

          
          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrders(
                activeOrders,
                true,
              ),
              _buildOrders(
                historyOrders,
                false,
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildOrders(
  List<Order> orders,
  bool active,
) {
  if (orders.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            active
                ? Icons.receipt_long
                : Icons.history,
            size: 90,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            active
                ? "No Current Orders"
                : "No Order History",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: orders.length,
    itemBuilder: (context, index) {
      final order = orders[index];

      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderTrackingScreen(
                order: order,
              ),
            ),
          );
        },
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_long,
                      color: Color(0xff2563EB),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Order #${order.id.substring(order.id.length - 6)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor(order.status)
                            .withOpacity(.12),
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          color: statusColor(order.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Text(
                  order.restaurantName,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const Divider(height: 28),

                const Text(
                  "Items",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                ...order.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(item.food.name),
                        ),
                        Text(
                          "x${item.quantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(height: 28),

                Row(
                  children: [
                    const Icon(
                      Icons.credit_card,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text("Payment"),
                    const Spacer(),
                    Text(
                      order.paymentMethod,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text("ETA"),
                    const Spacer(),
                    Text(
                      "${order.estimatedTime} mins",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                if (order.riderName != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.delivery_dining,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      const Text("Rider"),
                      const Spacer(),
                      Text(
                        order.riderName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text("Total"),
                    const Spacer(),
                    Text(
                      order.totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Color(0xff2563EB),
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

    }