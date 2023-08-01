import 'package:flutter/material.dart';
import 'package:janganan/utils/colors.dart';
// import 'package:janganan/widgets/campaign_banner.dart';
// import 'package:janganan/widgets/campaign_slider.dart';
// import 'package:janganan/widgets/category_item.dart';
// import 'package:janganan/widgets/div_title.dart';

class AppBarScroll extends StatelessWidget {
  const AppBarScroll({
    super.key,
    required this.title,
    this.actions,
    required this.sliverChildListDelegate,
  });

  final String title;
  final Widget? actions;
  final SliverChildListDelegate sliverChildListDelegate;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColor.primaryColor,
          pinned: true,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              // Reusable AppBar title
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
              // Reusable actions Widget
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
        SliverList(
          delegate: sliverChildListDelegate,
        ),
      ],
    );
  }
}
