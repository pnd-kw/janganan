import 'package:flutter/material.dart';
import 'package:janganan/presentation/widgets/background_body.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/home_appbar_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // BackgroundBody in widgets directory
      body: BackgroundBody(
        // HomeAppBarBody in home screen widgets directory
        widget: HomeAppBarBody(),
      ),
      // BottomNavigation in widgets directory
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
