import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/style.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({super.key, required this.product});

  final GroceryItem product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: product.note != null
            ? Style(outputText: product.note!)
            : const SizedBox.shrink());
  }
}
