import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/janganan_bloc.dart';
import 'package:janganan/config/theme.dart';
import 'package:janganan/presentation/screens/add_vegetable_screen.dart';
import 'package:janganan/presentation/screens/fruits_screen.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/presentation/screens/spices_screen.dart';
import 'package:janganan/presentation/screens/vegetables_screen.dart';

void main() {
  debugRepaintRainbowEnabled = false;
  runApp(const Janganan());
}

class Janganan extends StatelessWidget {
  const Janganan({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => JangananBloc(), //..add(JangananLoaded()),
        ),
      ],
      child: MaterialApp(
        title: 'Janganan',
        theme: theme,
        // home: const HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomeScreen(),
          '/vegetables-screen': (ctx) => const VegetablesScreen(),
          '/fruits-screen': (ctx) => const FruitsScreen(),
          '/spices-screen': (ctx) => const SpicesScreen(),
          '/add-vegetable-screen': (ctx) => const AddVegetableScreen(),
        },
      ),
    );
  }
}
