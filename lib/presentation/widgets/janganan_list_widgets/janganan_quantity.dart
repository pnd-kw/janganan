import 'package:flutter/material.dart';

class JangananQuantity extends StatelessWidget {
  const JangananQuantity({
    super.key,
    required this.quantityDecrement,
    required this.quantity,
    required this.quantityIncrement,
  });

  final void Function()? quantityDecrement;
  final String quantity;
  final void Function()? quantityIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: IconButton(
            onPressed: quantityDecrement,
            icon: const Icon(Icons.remove),
            iconSize: 10,
          ),
        ),
        Text(
          quantity,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        SizedBox(
          height: 30,
          child: IconButton(
            onPressed: quantityIncrement,
            icon: const Icon(Icons.add),
            iconSize: 10,
          ),
        ),
        Text(
          '/kg/buah/ikat',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ],
    );
  }
}
