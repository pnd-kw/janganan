import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/card/bloc/card_bloc.dart';
import 'package:janganan/data/models/janganan_item_model.dart';

class JangananListItems extends StatelessWidget {
  const JangananListItems({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.filteredItems,
  });

  final int index;
  final bool isExpanded;
  final List<JangananItem> filteredItems;

  @override
  Widget build(BuildContext context) {
    // final jangananState = context.watch<JangananBloc>().state;

    return GestureDetector(
      onTap: () {
        context.read<CardBloc>().add(ToggleCard(cardIndex: index));
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 3),
                    // blurRadius: 7,
                    // spreadRadius: 5,
                  ),
                ]),
            height: isExpanded ? 200 : 100,
            child: Center(
              child: Column(
                children: [
                  Text(
                    filteredItems[index].itemName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(filteredItems[index].category.title),
                      SizedBox(
                        height: 20,
                        child: filteredItems[index].category.catIcon,
                      )
                    ],
                  ),
                  Text('stok: ${filteredItems[index].stock.toString()}'),
                  Text('harga: ${filteredItems[index].price.toString()}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
