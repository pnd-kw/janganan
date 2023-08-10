import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/card/bloc/card_bloc.dart';
import 'package:janganan/bloc/janganan/janganan_bloc.dart';
import 'package:janganan/presentation/widgets/janganan_list_items.dart';

class JangananList extends StatelessWidget {
  const JangananList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JangananBloc, JangananState>(
      builder: (context, jangananState) {
        if (jangananState is JangananInitial) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          );
        } else if (jangananState is LoadByCategory) {
          return ListView.builder(
            itemCount: jangananState.filteredItems.length,
            itemBuilder: (ctx, index) {
              return BlocBuilder<CardBloc, CardState>(
                builder: (context, cardState) {
                  return JangananListItems(
                    index: index,
                    isExpanded: cardState is CardInitial &&
                        cardState.expandedIndex == index,
                    filteredItems: jangananState.filteredItems,
                  );
                },
              );
            },
          );
        } else {
          return const Text('Something went wrong!');
        }
      },
    );
  }
}
