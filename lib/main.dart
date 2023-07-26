import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:janganan/screens/home_screen.dart';
import 'package:janganan/utils/theme.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(const Janganan());
}

class Janganan extends StatelessWidget {
  const Janganan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
