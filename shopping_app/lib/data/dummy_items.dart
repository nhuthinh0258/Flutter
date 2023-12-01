import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/data/categories.dart';

import '../models/category.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories['C4']!,
      note: 'note cho phần category'),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories['C1']!,
      ),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories['C2']!,
      note: 'note cho phần category'),
  GroceryItem(
      id: 'd',
      name: 'Example',
      quantity: 1,
      category: categories['C3']!,
      note: 'note cho phần category'),
];
