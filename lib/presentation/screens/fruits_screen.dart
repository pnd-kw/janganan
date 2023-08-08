import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/janganan_bloc.dart';
import 'package:janganan/presentation/widgets/bottom_navigation.dart';

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
      body: BlocBuilder<JangananBloc, JangananState>(
        builder: (context, state) {
          if (state is JangananInitial) {
            return CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            );
          }
          if (state is LoadByCategory) {
            return ListView.builder(
              itemCount: state.filteredItems.length,
              itemBuilder: (ctx, index) => Card(
                child: Column(
                  children: [
                    Text(
                      state.filteredItems[index].itemName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.filteredItems[index].category.title),
                        SizedBox(
                          height: 20,
                          child: state.filteredItems[index].category.catIcon,
                        ),
                      ],
                    ),
                    Text(
                        'stok: ${state.filteredItems[index].stock.toString()}'),
                    Text(
                        'harga: ${state.filteredItems[index].price.toString()} /kg'),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something went wrong!');
          }
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
