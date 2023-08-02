import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/config/theme.dart';
import 'package:janganan/presentation/screens/vegetables_screen.dart';

void main() {
  debugRepaintRainbowEnabled = false;
  runApp(const Janganan());
}

class Janganan extends StatelessWidget {
  const Janganan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janganan',
      theme: theme,
      // home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/vegetables-screen': (_) => const VegetablesScreen(),
      },
    );
  }
}
