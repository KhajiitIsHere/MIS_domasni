import 'package:domasno2/model/burger.dart';
import 'package:domasno2/model/named_burger.dart';
import 'package:domasno2/model/user.dart';
import 'package:domasno2/widgets/saved_burger.dart';
import 'package:flutter/material.dart';

import '../widgets/order_burger_form.dart';

class BurgersPage extends StatelessWidget {
  final List<NamedBurger> burgers;
  final void Function(Burger, String) onOrder;
  final void Function() openHomePage;
  final User loggedInUser;

  const BurgersPage({
    required this.burgers,
    required this.onOrder,
    required this.openHomePage,
    required this.loggedInUser,
    Key? key,
  }) : super(key: key);

  void handleOrder(BuildContext context, Burger burger) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => OrderBurgerForm(
          addresses: loggedInUser.addresses,
          onOrder: (address) {
            onOrder(burger, address);
            Navigator.of(context).pop();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    print(burgers);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Burgers'),
        leading: IconButton(
          onPressed: openHomePage,
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openHomePage,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: burgers
              .map(
                (e) => SavedBurger(
                  burger: e,
                  onOrder: () => handleOrder(context, e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
