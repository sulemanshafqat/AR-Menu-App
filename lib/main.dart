import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/navigation/bottom_nav.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/orders_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child: const ARMenuApp(),
    ),
  );
}

class ARMenuApp extends StatelessWidget {
  const ARMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpectoXR AR Menu',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff2563EB),
      ),
      home: const BottomNav(),
    );
  }
}