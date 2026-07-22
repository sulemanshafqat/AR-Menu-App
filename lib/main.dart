import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/menu_provider.dart';
import 'firebase_options.dart';
import 'providers/category_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/orders_provider.dart';

import 'screens/auth/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ARMenuApp());
}

class ARMenuApp extends StatelessWidget {
  const ARMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
  create: (_) => CategoryProvider(),
),
        ChangeNotifierProvider(
  create: (_) => MenuProvider(),
),
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SpectoXR AR Menu",
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xff2563EB),
        ),
        home: const AuthGate(),
      ),
    );
  }
}