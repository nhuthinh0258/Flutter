import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widget/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select category you want'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: //cấu hình cách các phần tử trong grid được sắp xếp và thay đổi kích thước.
            const SliverGridDelegateWithFixedCrossAxisCount(
          //tạo một grid với số cột cố định
          crossAxisCount: 2, //Số cột trong grid
          childAspectRatio: 3 / 2, //Tỷ lệ chiều rộng/chiều cao của mỗi phần tử
          crossAxisSpacing: 20, //Khoảng cách giữa các phần tử theo chiều ngang
          mainAxisSpacing: 20, // Khoảng cách giữa các phần tử theo chiều dọc
        ),
        children: [
          ...availableCategories.map((category) {
            return CategoryGridItem(category: category);
          },).toList()
        ],
      ),
    );
  }
}
