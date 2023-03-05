import 'package:flutter/material.dart';

class OrderBurgerForm extends StatefulWidget {
  final List<String> addresses;
  final void Function(String) onOrder;

  const OrderBurgerForm({
    required this.addresses,
    required this.onOrder,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderBurgerForm> createState() => _OrderBurgerFormState();
}

class _OrderBurgerFormState extends State<OrderBurgerForm> {
  void orderHandler(String address) {
    widget.onOrder(address);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: SingleChildScrollView(
        child: widget.addresses.isNotEmpty
            ? Column(
                children: widget.addresses
                    .map((e) => ElevatedButton(
                          onPressed: () => orderHandler(e),
                          child: Text(e),
                        ))
                    .toList(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: const Center(
                    child: Text(
                  'No addresses added, go to profile and add an address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))),
      ),
    );
  }
}
