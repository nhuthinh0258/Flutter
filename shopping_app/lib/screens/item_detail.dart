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
      body: Padding(
        padding: const EdgeInsets.all(16),
        //Kiểm tra phần note có null hay không, nếu null thì không hiển thị gì (SizedBox.shrink()), nếu có hiển thị ra phần ghi chú
        child: product.note != null
            ? Style(outputText: product.note!)
            : const SizedBox.shrink(),
      ),
    );
  }
}
