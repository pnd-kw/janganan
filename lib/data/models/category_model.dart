import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum Categories {
  vegetable,
  fruit,
  spices,
}

class Category extends Equatable {
  final String title;
  final Image catIcon;

  const Category({
    required this.title,
    required this.catIcon,
  });

  @override
  List<Object> get props => [title, catIcon];
}
