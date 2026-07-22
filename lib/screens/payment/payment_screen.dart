import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';

import '../success/order_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;

  const PaymentScreen({
    super.key,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "Cash on Delivery";

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            _paymentOption(
              "Cash on Delivery",
              Icons.payments_outlined,
            ),

            const SizedBox(height: 12),

            _paymentOption(
              "Credit / Debit Card",
              Icons.credit_card,
            ),

            const SizedBox(height: 12),

            _paymentOption(
              "Easypaisa",
              Icons.account_balance_wallet_outlined,
            ),

            const SizedBox(height: 12),

            _paymentOption(
              "JazzCash",
              Icons.phone_android,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () async {
                  final orders = context.read<OrdersProvider>();
                  final auth = context.read<AuthProvider>();

                  if (auth.user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please login first."),
                      ),
                    );
                    return;
                  }

                  await orders.placeOrder(
                    cartItems: List.from(cart.items),
                    paymentMethod: selectedMethod,
                    totalPrice: cart.totalPrice,

                    restaurantName: "Specto Restaurant",
                    deliveryAddress: widget.deliveryAddress,

                    customerId: auth.user!.uid,
                    customerName: widget.customerName,
                    customerPhone: widget.customerPhone,
                  );

                  cart.clearCart();

                  if (!mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrderSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(
    String title,
    IconData icon,
  ) {
    final selected = selectedMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff2563EB)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xff2563EB)
                : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: selected
                  ? Colors.white
                  : const Color(0xff2563EB),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: selected
                  ? const Icon(
                      Icons.check_circle,
                      key: ValueKey(true),
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.radio_button_unchecked,
                      key: ValueKey(false),
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}