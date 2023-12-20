import 'package:flutter/material.dart';
import 'package:shopping_app/models/category.dart';
import 'package:shopping_app/style.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.listCategory,
    required this.isLoadingCata,
  });

  final List<Category> listCategory;
  final bool isLoadingCata;

  @override
  Widget build(BuildContext context) {
    Widget item(context, index) {
      return Dismissible(
        key: ValueKey(listCategory[index].id),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        ),
        onDismissed: (direction) {},
        child: InkWell(
          child: Card(
            margin: const EdgeInsets.all(6),
            color: Theme.of(context).primaryColorLight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListTile(
                leading: Row(
                  //Đảm bảo row chỉ chiếm đủ không gian cho các con của nó
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: listCategory[index].color,
                      ),
                      width: 100,
                      height: 60,
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                  ],
                ),
                title: Style(outputText: listCategory[index].name),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.update),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
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
            'Hiện không có loại nào, hãy thêm loại sản phẩm!',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark.withOpacity(0.75)),
          )
        ],
      ),
    );

    // Quản lý trạng thái Loading
    if (isLoadingCata) {
      mainContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (listCategory.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: listCategory.length,
        itemBuilder: item,
      );
    }
    return mainContent;
  }
}
