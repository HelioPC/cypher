import 'package:cypher/presentation/home/widgets/home_card.dart';
import 'package:cypher/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = (width / 2) - 14;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            backgroundColor: Colors.black,
            stretchTriggerOffset: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                'Início',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 28)),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Criptografia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'é uma área da criptologia que estuda e pratica princípios e técnicas para comunicação segura na presença de terceiros, chamados "adversários"',
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCard(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.aesScreen);
                          },
                          width: cardWidth,
                          imageName: 'assets/images/shield-blue.jpg',
                          title: 'Criptografia simétrica',
                        ),
                        HomeCard(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.rsaScreen);
                          },
                          width: cardWidth,
                          imageName: 'assets/images/shield-pink.jpg',
                          title: 'Criptografia assimétrica',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
