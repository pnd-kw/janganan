enum Categories {
  vegetable,
  fruit,
  spices,
}

class Vegetable {
  final String id;
  final String vegetableName;
  final category = Categories;
  final double stock;
  final double price;

  Vegetable({
    required this.id,
    required this.vegetableName,
    required this.stock,
    required this.price,
  });
}
