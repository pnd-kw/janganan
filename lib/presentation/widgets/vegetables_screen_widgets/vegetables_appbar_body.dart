import 'package:flutter/material.dart';
import 'package:janganan/presentation/widgets/appbar_scroll.dart';

class VegetablesAppbarBody extends StatelessWidget {
  const VegetablesAppbarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarScroll(
      title: 'Vegetables',
      sliverChildListDelegate: SliverChildListDelegate([]),
    );
  }
}
