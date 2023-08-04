import 'package:flutter/material.dart';
import 'package:janganan/data/models/category_model.dart';

final categories = {
  Categories.vegetable: Category(
    title: 'Vegetable',
    catIcon: Image.asset('assets/images/ic-vegetables.png'),
  ),
  Categories.fruit: Category(
    title: 'Fruit',
    catIcon: Image.asset('assets/images/ic-fruits.png'),
  ),
  Categories.spices: Category(
    title: 'Spices',
    catIcon: Image.asset('assets/images/ic-spices.png'),
  ),
};
