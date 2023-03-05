import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  final double size;
  final double price;

  const Price({Key? key, required this.size, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      height: size,
      width: size,
      child: Center(
        child: FittedBox(
          child: Text(
            '${price.toStringAsFixed(0)} mkd',
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
