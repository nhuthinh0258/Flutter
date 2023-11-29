
import 'package:shopping_app/models/category.dart';

class GroceryItem{
  final String id;
  final String name;
  final int quantity;
  final String? note;
  final Category category;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    this.note,
    required this.category,
  });
}