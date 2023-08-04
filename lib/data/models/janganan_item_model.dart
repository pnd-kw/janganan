import 'package:janganan/data/models/category_model.dart';

class JangananItem {
  final String id;
  final String itemName;
  final Category category;
  final double stock;
  final double price;

  JangananItem({
    required this.id,
    required this.itemName,
    required this.category,
    required this.stock,
    required this.price,
  });
}
