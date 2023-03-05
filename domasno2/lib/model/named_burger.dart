import 'package:domasno2/model/ingredient.dart';
import 'package:domasno2/model/user.dart';

import 'burger.dart';

class NamedBurger extends Burger {
  final String name;
  final User creator;

  NamedBurger({
    required this.name,
    required this.creator,
    Ingredient? bun,
    List<Ingredient>? cheese,
    List<Ingredient>? meat,
    List<Ingredient>? salad,
    List<Ingredient>? sauces,
  }) : super(bun: bun, cheese: cheese, meat: meat, salad: salad, sauces: sauces);

  @override
  String toString() {
    return 'NamedBurger{name: $name} ${super.toString()}';
  }
}
