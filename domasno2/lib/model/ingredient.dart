class Ingredient {
  late String name;
  late double price;

  Ingredient({
    required this.name,
    required this.price,
  });

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = (json['price'] as int).toDouble();
  }

  @override
  String toString() {
    return 'Ingredient{name: $name}';
  }
}
