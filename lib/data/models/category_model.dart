import 'package:flutter/material.dart';

enum Categories {
  vegetable,
  fruit,
  spices,
}

class Category {
  final String title;
  final Image catIcon;

  Category({
    required this.title,
    required this.catIcon,
  });
}
