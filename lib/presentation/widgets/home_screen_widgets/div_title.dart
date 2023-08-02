import 'package:flutter/material.dart';

class DivTitle extends StatelessWidget {
  const DivTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.grey),
      ),
    );
  }
}
