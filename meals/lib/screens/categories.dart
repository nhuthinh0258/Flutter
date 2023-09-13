import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widget/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key,required this.availableMeal});

  final List<Meal> availableMeal ;

  void onSelectCategory(BuildContext context, Category category) {
    final filterMeal = availableMeal.where((meal) {
      //lọc các phần tử trong một danh sách dựa trên một điều kiện cho trước(ở đây là meal)
      return meal.categories.contains(category
          .id); //kiểm tra xem một danh sách categories của đối tượng meal có chứa một phần tử có giá trị bằng category.id hay không.
    }).toList();

    Navigator.push(
      //phương thức trong Flutter để chuyển đổi giữa các màn hình (routes) trong ứng dụng
      context,
      MaterialPageRoute(builder: ((ctx) {
        // widget trong Flutter được sử dụng để xác định một màn hình mới trong ứng dụng
        return MealScreen(
          meals: filterMeal,
          title: category.title,
        );
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
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
          ...availableCategories.map(
            (category) {
              return CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  return onSelectCategory(context,category);
                },
              );
            },
          ).toList()
        ]
    );
  }
}
