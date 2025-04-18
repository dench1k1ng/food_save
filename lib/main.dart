import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_save/core/theme/theme_provider.dart';
import 'package:food_save/features/auth/presentation/auth_gate.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => CartProvider()), // Добавили CartProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: const AuthGate(),
        );
      },
    );
  }
}
