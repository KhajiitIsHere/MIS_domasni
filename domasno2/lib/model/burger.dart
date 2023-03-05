import 'package:domasno2/model/ingredient_type.dart';
import 'package:domasno2/model/named_burger.dart';
import 'package:domasno2/model/user.dart';

import 'ingredient.dart';

class Burger {
  final Ingredient? bun;
  final List<Ingredient>? cheese;
  final List<Ingredient>? meat;
  final List<Ingredient>? salad;
  final List<Ingredient>? sauces;

  Burger({
    this.bun,
    this.cheese,
    this.meat,
    this.salad,
    this.sauces,
  });

  Burger copyWith({
    Ingredient? bun,
    List<Ingredient>? cheese,
    List<Ingredient>? meat,
    List<Ingredient>? salad,
    List<Ingredient>? sauces,
  }) {
    return Burger(
      bun: bun ?? this.bun,
      cheese: cheese ?? this.cheese,
      meat: meat ?? this.meat,
      salad: salad ?? this.salad,
      sauces: sauces ?? this.sauces,
    );
  }

  Burger getNewBurger(
      IngredientType ingredientType, List<Ingredient> ingredients) {
    if (ingredientType == IngredientType.cheese) {
      return copyWith(cheese: ingredients);
    } else if (ingredientType == IngredientType.meat) {
      return copyWith(meat: ingredients);
    } else if (ingredientType == IngredientType.salad) {
      return copyWith(salad: ingredients);
    } else {
      return copyWith(sauces: ingredients);
    }
  }

  double get totalPrice {
    final List<Ingredient> allIngredients = [];
    if (bun != null) {
      allIngredients.add(bun!);
    }
    if (cheese != null) {
      allIngredients.addAll(cheese!);
    }
    if (meat != null) {
      allIngredients.addAll(meat!);
    }
    if (salad != null) {
      allIngredients.addAll(salad!);
    }
    if (sauces != null) {
      allIngredients.addAll(sauces!);
    }

    double totalPrice = 0;
    for (var element in allIngredients) {
      totalPrice += element.price;
    }

    return totalPrice;
  }

  @override
  String toString() {
    return '$bun, $cheese, $meat, $salad, $sauces';
  }

  get meatList => meat ?? [];

  get cheeseList => cheese ?? [];

  get saladList => salad ?? [];

  get saucesList => sauces ?? [];

  String getIngredients() {
    return [bun, ...meatList, ...cheeseList, ...saladList, ...saucesList]
        .map((e) => e.name)
        .join(', ');
  }

  NamedBurger nameBurger(String name, User creator) {
    return NamedBurger(
      name: name,
      creator: creator,
      bun: bun,
      cheese: cheese,
      meat: meat,
      salad: salad,
      sauces: sauces,
    );
  }
}
