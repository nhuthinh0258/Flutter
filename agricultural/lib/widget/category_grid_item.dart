import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  final Category category;

  final void Function() onSelectCategory;


  @override
  Widget build(BuildContext context) {
    return InkWell(   //tạo ra một phản ứng hồi khi người dùng nhấn vào nó, thường được sử dụng để tạo các phần tử có khả năng tương tác như nút (button) hoặc các mục trong danh sách (list item)
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,  //xác định màu sắc của hiệu ứng nước (splash effect) khi người dùng nhấn vào widget.
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
