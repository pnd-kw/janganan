import 'package:flutter/material.dart';
import 'package:janganan/utils/colors.dart';

class AppBarScroll extends StatelessWidget {
  const AppBarScroll({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColor.primaryColor,
          expandedHeight: 150,
          pinned: true,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: actions,
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/appbar-bg-img.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SliverFillRemaining(),
      ],
    );
  }
}
