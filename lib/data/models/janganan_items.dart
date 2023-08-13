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
    itemImg: 'assets/images/kangkung-img.png',
  ),
  JangananItem(
    id: '1',
    itemName: 'Jeruk',
    category: categories[Categories.fruit]!,
    stock: 2.5,
    price: 5000.0,
    itemImg: 'assets/images/jeruk-img.png',
  ),
  JangananItem(
    id: '2',
    itemName: 'Bawang Merah',
    category: categories[Categories.spices]!,
    stock: 10.0,
    price: 10000.0,
    itemImg: 'assets/images/bwg-mrh-img.png',
  ),
  JangananItem(
    id: '3',
    itemName: 'Bayam',
    category: categories[Categories.vegetable]!,
    stock: 15.0,
    price: 3500.0,
    itemImg: 'assets/images/bayam-img.png',
  ),
];
