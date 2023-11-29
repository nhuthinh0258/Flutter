import 'package:flutter/material.dart';
import 'package:shopping_app/data/dummy_items.dart';
import 'package:shopping_app/style.dart';
import 'package:shopping_app/models/grocery_item.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.onSelectedItem});

  final void Function(GroceryItem product) onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: (){
              return onSelectedItem(groceryItems[index]);
            },
            child: Card(
              margin:const EdgeInsets.all(6),
              color: Theme.of(context).primaryColorLight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListTile(
                  // tiêu đề chính của ListTile
                  title: Style(
                    outputText: groceryItems[index].name,
                  ), 
                  //leadng Thường được sử dụng cho biểu tượng hoặc hình ảnh.
                  leading: Container(
                    width: 100,
                    height: 100,
                    color: groceryItems[index].category.color,
                  ),
                  //trailing Có thể sử dụng cho biểu tượng hoặc chức năng tương tác như một nút
                  trailing: Style(
                    outputText: groceryItems[index].quantity.toString(),
                  ),
                ),
                // child: Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 100,
                //       color: groceryItems[index].category.color,
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: Style(
                //         outputText: groceryItems[index].name,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Style(outputText: groceryItems[index].quantity.toString())
                //   ],
                // ),
              ),
            ),
          );
        }));
  }
}
