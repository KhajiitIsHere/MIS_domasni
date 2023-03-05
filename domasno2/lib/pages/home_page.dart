import 'package:domasno2/model/burger.dart';
import 'package:domasno2/model/named_burger.dart';
import 'package:domasno2/model/user.dart';
import 'package:domasno2/widgets/order_burger_form.dart';
import 'package:domasno2/widgets/price.dart';
import 'package:domasno2/widgets/save_burger_form.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../model/ingredient.dart';
import '../model/ingredient_type.dart';

class HomePage extends StatefulWidget {
  final Map<IngredientType, List<Ingredient>> ingredients;
  final User loggedInUser;
  final void Function(NamedBurger) onSave;
  final void Function(Burger, String) onOrder;
  final void Function() openBurgersPage;
  final void Function() openAccountPage;
  final void Function() openMapPage;
  final void Function() openCameraPage;

  const HomePage({
    Key? key,
    required this.ingredients,
    required this.loggedInUser,
    required this.onSave,
    required this.onOrder,
    required this.openBurgersPage,
    required this.openAccountPage,
    required this.openMapPage,
    required this.openCameraPage,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Burger _burger = Burger();

  @override
  void initState() {
    super.initState();
    _burger = Burger(bun: widget.ingredients[IngredientType.buns]!.first);
  }

  List<MultiSelectItem<Ingredient>> _getMultiSelectItems(
      IngredientType ingredientType) {
    if (widget.ingredients[ingredientType] == null) {
      return [];
    }
    return widget.ingredients[ingredientType]!
        .map((e) => MultiSelectItem(e, e.name))
        .toList();
  }

  List<DropdownMenuItem<Ingredient>> _getDropdownItems(
      IngredientType ingredientType) {
    if (widget.ingredients[ingredientType] == null) {
      return [];
    }
    return widget.ingredients[ingredientType]!
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.name),
            ))
        .toList();
  }

  void _fillIngredients(
      List<Ingredient> ingredients, IngredientType ingredientType) {
    setState(() {
      _burger = _burger.getNewBurger(ingredientType, ingredients);
    });
  }

  void handleSave() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SaveBurgerForm((burgerName) {
            final burgerToSave = _burger.nameBurger(burgerName, widget.loggedInUser);

            widget.onSave(burgerToSave);
            Navigator.of(context).pop();
          });
        });
  }

  void handleOrder() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => OrderBurgerForm(
              addresses: widget.loggedInUser.addresses,
              onOrder: (address) {
                widget.onOrder(_burger, address);
                Navigator.of(context).pop();
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Burgers'),
        actions: [
          IconButton(onPressed: widget.openCameraPage, icon: const Icon(Icons.camera_alt)),
          IconButton(onPressed: widget.openMapPage, icon: const Icon(Icons.map),),
          TextButton(
            onPressed: widget.openBurgersPage,
            child: const Text(
              'Saved Burgers',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: widget.openAccountPage,
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                Image.asset(
                  'assets/images/burger.png',
                  width: 330,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Price(size: 100, price: _burger.totalPrice),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: handleSave,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: handleOrder,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  child: const Text('Order'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 11),
                child: const Text(
                  'Buns:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DropdownButton(
                onChanged: (bun) => setState(() {
                  _burger = _burger.copyWith(bun: bun);
                }),
                items: _getDropdownItems(IngredientType.buns),
                value: _burger.bun,
                underline: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
                icon: const Icon(Icons.arrow_downward),
              ),
            ]),
            MultiSelectDialogField(
              buttonText: const Text(
                'Cheese',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              items: _getMultiSelectItems(IngredientType.cheese),
              onConfirm: (selectedIngredients) =>
                  _fillIngredients(selectedIngredients, IngredientType.cheese),
            ),
            MultiSelectDialogField(
              buttonText: const Text(
                'Meat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              items: _getMultiSelectItems(IngredientType.meat),
              onConfirm: (selectedIngredients) =>
                  _fillIngredients(selectedIngredients, IngredientType.meat),
            ),
            MultiSelectDialogField(
              buttonText: const Text(
                'Salad',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              items: _getMultiSelectItems(IngredientType.salad),
              onConfirm: (selectedIngredients) =>
                  _fillIngredients(selectedIngredients, IngredientType.salad),
            ),
            MultiSelectDialogField(
              buttonText: const Text(
                'Sauces',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              items: _getMultiSelectItems(IngredientType.sauces),
              onConfirm: (selectedIngredients) =>
                  _fillIngredients(selectedIngredients, IngredientType.sauces),
            ),
          ],
        ),
      ),
    );
  }
}
