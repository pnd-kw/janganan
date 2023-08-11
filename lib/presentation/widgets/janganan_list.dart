import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/expanded_container/expanded_container_bloc.dart';
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
              return BlocBuilder<ExpandedContainerBloc, ExpandedContainerState>(
                builder: (context, expandedContainerState) {
                  return JangananListItems(
                    index: index,
                    isExpanded:
                        expandedContainerState is ExpandedContainerInitial &&
                            expandedContainerState.expandedIndex == index,
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
