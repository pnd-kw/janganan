import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:janganan/bloc/janganan_bloc.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';
import 'package:janganan/presentation/widgets/janganan_list.dart';

class FruitsScreen extends StatelessWidget {
  const FruitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
          style: ButtonStyle(
            iconSize: const MaterialStatePropertyAll(20),
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
            iconColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.background,
            ),
          ),
        ),
        title: Text(
          'Fruits',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: const JangananList(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
