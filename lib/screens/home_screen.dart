import 'package:flutter/material.dart';
import 'package:janganan/widgets/appbar_scroll.dart';
import 'package:janganan/widgets/background_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBody(
        widget: AppBarScroll(
          title: 'Hello!',
          actions: TextButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/images/ic-cart.png'),
            label: Text(
              'Cart',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(3),
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              shadowColor: MaterialStatePropertyAll(
                Colors.black.withOpacity(0.8),
              ),
            ),
          ),
        ),
        // body: Container(
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/bg-img.png'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: AppBarScroll(
        //     title: 'Hello!',
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
      ),
    );
  }
}
