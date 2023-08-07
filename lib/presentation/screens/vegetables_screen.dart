import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/janganan_bloc.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';

class VegetablesScreen extends StatelessWidget {
  const VegetablesScreen({super.key});

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
          'Vegetables',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.background),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-vegetable-screen');
            },
            icon: const Icon(Icons.add),
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
        ],
      ),
      body: BlocBuilder<JangananBloc, JangananState>(
        builder: (context, state) {
          if (state is JangananInitial) {
            return CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            );
          }
          if (state is JangananLoad) {
            return ListView.builder(
              itemCount: state.jangananItems.length,
              itemBuilder: (ctx, index) => Card(
                child: Column(
                  children: [
                    Text(state.jangananItems[index].itemName),
                    Text(state.jangananItems[index].category.title),
                    Text(state.jangananItems[index].stock.toString()),
                    Text(state.jangananItems[index].price.toString()),
                  ],
                ),
              ),
            );
            // if (state is JangananLoad) {
            //   return ListView.builder(
            //     itemCount: state.jangananItems.length,
            //     itemBuilder: (ctx, index) => Card(
            //       child: Column(
            //         children: [
            //           Text(state.jangananItems[index].itemName),
            //           // Text(state.jangananItems[index].category.toString()),
            //         ],
            //       ),
            //     ),
            //   );
          } else {
            return const Text('Something went wrong!');
          }
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
