import 'package:flutter/material.dart';

class RsaScreen extends StatefulWidget {
  const RsaScreen({super.key});

  @override
  State<RsaScreen> createState() => _RsaScreenState();
}

class _RsaScreenState extends State<RsaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Criptografia assimétrica'),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text('Criptografia assimétrica'),
            ),
          )
        ],
      ),
    );
  }
}
