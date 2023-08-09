import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/janganan_bloc.dart';

class JangananList extends StatelessWidget {
  const JangananList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JangananBloc, JangananState>(
      builder: (context, state) {
        if (state is JangananInitial) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          );
        } else if (state is LoadByCategory) {
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
                      )
                    ],
                  ),
                  Text('stok: ${state.filteredItems[index].stock.toString()}'),
                  Text(
                      'harga: ${state.filteredItems[index].price.toString()} /ikat'),
                ],
              ),
            ),
          );
        } else {
          return const Text('Something went wrong!');
        }
      },
    );
  }
}
