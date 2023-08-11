import 'package:equatable/equatable.dart';
import 'package:janganan/data/models/category_model.dart';

class JangananItem extends Equatable {
  final String id;
  final String itemName;
  final Category category;
  final double stock;
  final double price;
  final String itemImg;

  const JangananItem(
      {required this.id,
      required this.itemName,
      required this.category,
      required this.stock,
      required this.price,
      required this.itemImg});

  @override
  List<Object> get props => [id, itemName, category, stock, price, itemImg];
}
