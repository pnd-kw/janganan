import 'package:janganan/data/models/categories.dart';
import 'package:janganan/data/models/category_model.dart';
import 'package:janganan/data/models/janganan_item_model.dart';

final jangananItems = [
  JangananItem(
    id: '0',
    itemName: 'Kangkung',
    category: categories[Categories.vegetable]!,
    stock: 20.0,
    price: 3000.0,
  ),
  JangananItem(
    id: '1',
    itemName: 'Jeruk',
    category: categories[Categories.fruit]!,
    stock: 2.5,
    price: 25000.0,
  ),
  JangananItem(
    id: '2',
    itemName: 'Bawang Merah',
    category: categories[Categories.spices]!,
    stock: 10.0,
    price: 40000.0,
  ),
];
