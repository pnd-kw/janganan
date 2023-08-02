import 'package:flutter/material.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';
import 'package:janganan/presentation/widgets/vegetables_screen_widgets/vegetables_appbar_body.dart';

class VegetablesScreen extends StatelessWidget {
  static const route = 'vegetables-list-screen';
  const VegetablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VegetablesAppbarBody(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
