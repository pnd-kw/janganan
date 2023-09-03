import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:janganan/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:janganan/bloc/expanded_container/expanded_container_bloc.dart';
import 'package:janganan/bloc/janganan/janganan_bloc.dart';

import 'package:janganan/config/theme.dart';

import 'package:janganan/presentation/screens/add_vegetable_screen.dart';
import 'package:janganan/presentation/screens/fruits_screen.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/presentation/screens/login_screen.dart';
import 'package:janganan/presentation/screens/onboarding_screen.dart';
import 'package:janganan/presentation/screens/order_screen.dart';
import 'package:janganan/presentation/screens/register_screen.dart';
import 'package:janganan/presentation/screens/spices_screen.dart';
import 'package:janganan/presentation/screens/user_screen.dart';
import 'package:janganan/presentation/screens/vegetables_screen.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';

void main() async {
  debugRepaintRainbowEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Janganan());
}

class Janganan extends StatelessWidget {
  const Janganan({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
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
          '/': (context) => const OnBoardingScreen(),
          '/login-screen': (context) => const LoginScreen(),
          '/register-screen': (context) => const RegisterScreen(),
          '/bottom-navigation': (context) => const BottomNavigation(),
          '/home-screen': (context) => const HomeScreen(),
          '/order-screen': (context) => const OrderScreen(),
          '/user-screen': (context) => const UserScreen(),
          '/vegetables-screen': (context) => const VegetablesScreen(),
          '/fruits-screen': (context) => const FruitsScreen(),
          '/spices-screen': (context) => const SpicesScreen(),
          '/add-vegetable-screen': (context) => const AddVegetableScreen(),
        },
      ),
    );
  }
}
