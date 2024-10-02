import 'package:flutter/material.dart';

class AesScreen extends StatefulWidget {
  const AesScreen({super.key});

  @override
  State<AesScreen> createState() => _AesScreenState();
}

class _AesScreenState extends State<AesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Criptografia simétrica'),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text('Criptografia simétrica'),
            ),
          )
        ],
      ),
    );
  }
}
