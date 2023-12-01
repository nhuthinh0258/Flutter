import 'package:flutter/material.dart';
import 'package:shopping_app/screens/update_item.dart';
import 'package:shopping_app/style.dart';
import 'package:shopping_app/models/grocery_item.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.onSelectedItem,
      required this.listGroceryItem,
      required this.onRemoveItem,
      required this.onUpdateItem});

  final void Function(GroceryItem product) onSelectedItem;
  final void Function(GroceryItem product) onRemoveItem;
  final void Function(GroceryItem product) onUpdateItem;
  final List<GroceryItem> listGroceryItem;

  // void updateItem(BuildContext context, GroceryItem product) async {
  //   final updateItem = await Navigator.of(context).push<GroceryItem>(
  //     MaterialPageRoute(builder: (ctx) {
  //       return UpdateItem(product: product,);
  //     }),
  //   );
  //   if(updateItem != null){
  //     setState
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget item(context, index) {
      void dismissed(direction) {
        onRemoveItem(listGroceryItem[index]);
      }

      return Dismissible(
          key: ValueKey(listGroceryItem[index].id),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          ),
          onDismissed: dismissed,
          child: InkWell(
            onTap: () {
              return onSelectedItem(listGroceryItem[index]);
            },
            child: Card(
              margin: const EdgeInsets.all(6),
              color: Theme.of(context).primaryColorLight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ListTile(
                  // tiêu đề chính của ListTile
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Style(
                        outputText: listGroceryItem[index].name,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Style(
                          outputText:
                              'Số lượng: ${listGroceryItem[index].quantity.toString()}')
                    ],
                  ),
                  //leadng Thường được sử dụng cho biểu tượng hoặc hình ảnh.
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: listGroceryItem[index].category.color,
                    ),
                    width: 100,
                    height: 60,
                  ),
                  //trailing Có thể sử dụng cho biểu tượng hoặc chức năng tương tác như một nút
                  trailing: IconButton(
                    onPressed: () {
                      onUpdateItem(listGroceryItem[index]);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.black,
                  ),
                ),
                // child: Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 100,
                //       color: listGroceryItem[index].category.color,
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: Style(
                //         outputText: listGroceryItem[index].name,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Style(outputText: listGroceryItem[index].quantity.toString())
                //   ],
                // ),
              ),
            ),
          ));
    }

    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/cactus.png',
              width: 100,
              height: 100,
              color: Theme.of(context).primaryColorDark.withOpacity(0.75)),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Hiện không có sản phẩm nào, hãy thêm sản phẩm!',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark.withOpacity(0.75)),
          )
        ],
      ),
    );

    if (listGroceryItem.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: listGroceryItem.length,
        itemBuilder: item,
      );
    }
    return mainContent;
  }
}
