import 'package:cypher/presentation/encryption/aes/aes_screen.dart';
import 'package:cypher/presentation/encryption/rsa/rsa_screen.dart';
import 'package:cypher/presentation/home/home_screen.dart';
import 'package:cypher/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CypherApp());
}

class CypherApp extends StatelessWidget {
  CypherApp({super.key});

  final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cypher App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.amber,
        ),
      ),
      routes: {
        AppRoutes.homeScreen: (context) => const HomeScreen(),
        AppRoutes.aesScreen: (context) => const AesScreen(),
        AppRoutes.rsaScreen: (context) => const RsaScreen(),
      },
    );
  }
}
