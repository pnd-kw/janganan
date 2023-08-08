import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {super.key,
      required this.catImage,
      required this.catTitle,
      required this.onPressed});

  final Image catImage;
  final String catTitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: IconButton.filled(
            onPressed: onPressed,
            style: Theme.of(context).iconButtonTheme.style,
            icon: catImage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            catTitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ],
    );
  }
}
