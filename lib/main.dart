import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/expanded_container/expanded_container_bloc.dart';
import 'package:janganan/bloc/janganan/janganan_bloc.dart';
import 'package:janganan/config/theme.dart';
import 'package:janganan/presentation/screens/add_vegetable_screen.dart';
import 'package:janganan/presentation/screens/fruits_screen.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/presentation/screens/order_screen.dart';
import 'package:janganan/presentation/screens/spices_screen.dart';
import 'package:janganan/presentation/screens/user_screen.dart';
import 'package:janganan/presentation/screens/vegetables_screen.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';

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
          create: (context) => JangananBloc(),
        ),
        BlocProvider(
          create: (context) => ExpandedContainerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Janganan',
        theme: theme,
        // home: const HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const BottomNavigation(),
          '/home-screen': (ctx) => const HomeScreen(),
          '/order-screen': (ctx) => const OrderScreen(),
          '/user-screen': (ctx) => const UserScreen(),
          '/vegetables-screen': (ctx) => const VegetablesScreen(),
          '/fruits-screen': (ctx) => const FruitsScreen(),
          '/spices-screen': (ctx) => const SpicesScreen(),
          '/add-vegetable-screen': (ctx) => const AddVegetableScreen(),
        },
      ),
    );
  }
}
