import 'package:flutter/material.dart';
import 'package:janganan/widgets/background_body.dart';
import 'package:janganan/widgets/bottom_navigation.dart';
import 'package:janganan/widgets/home_screen_widgets/home_appbar_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundBody(
        widget: HomeAppBarBody(),
      ),
      bottomNavigationBar: BottomNavigation(),
      // BackgroundBody in Widget Directory
      // body: BackgroundBody(
      //   // AppBarScroll in Widget Directory
      //   widget: AppBarScroll(
      //     title: 'Hello!',
      //     //Cart Button
      //     actions: TextButton.icon(
      //       onPressed: () {},
      //       icon: Image.asset('assets/images/ic-cart.png'),
      //       label: Text(
      //         'Cart',
      //         style: Theme.of(context).textTheme.titleSmall!.copyWith(
      //               color: Theme.of(context).colorScheme.onBackground,
      //             ),
      //       ),
      //       style: ButtonStyle(
      //         elevation: const MaterialStatePropertyAll(3),
      //         backgroundColor: const MaterialStatePropertyAll(Colors.white),
      //         shadowColor: MaterialStatePropertyAll(
      //           Colors.black.withOpacity(0.8),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // // Bottom Navigation in Widget Directory
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}
