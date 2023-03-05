import 'package:domasno2/model/named_burger.dart';
import 'package:domasno2/widgets/price.dart';
import 'package:flutter/material.dart';

class SavedBurger extends StatelessWidget {
  final NamedBurger burger;
  final void Function() onOrder;

  const SavedBurger({
    required this.burger,
    required this.onOrder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(burger.name),
        subtitle: Text(burger.getIngredients()),
        leading: TextButton(
          onPressed: onOrder,
          child: const Text('Order'),
        ),
        trailing: Price(price: burger.totalPrice, size: 50),
      ),
    );
  }
}
