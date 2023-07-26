import 'package:flutter/material.dart';

class BackgroundBody extends StatelessWidget {
  const BackgroundBody({super.key, required this.widget});

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-img.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: widget,
    );
  }
}
