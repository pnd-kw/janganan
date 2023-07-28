import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.catImage,
    required this.catTitle,
  });

  final Image catImage;
  final String catTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: IconButton.filled(
            onPressed: () {},
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
