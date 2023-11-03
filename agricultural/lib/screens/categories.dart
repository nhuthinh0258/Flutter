import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widget/category_grid_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableMeal});

  final List<Meal> availableMeal;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  //biến sẽ không được gán giá trị ngay lập tức. Thay vào đó, bạn sẽ gán giá trị cho nó sau này trong mã của bạn. Thông thường, điều này
  // được thực hiện trong phương thức initState
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      //2 tham số mặc định, có thể ko cần viết ra
      lowerBound: 0,
      upperBound: 1,
    );
    //phương thức trong Flutter được sử dụng để khởi động một hoạt hình (animation) hoặc đối tượng có khả năng hoạt hình
    animationController.forward();
  }

  //Khi một tài nguyên như AnimationController không còn cần thiết, nên gọi phương thức dispose để giải phóng tài nguyên đó. Điều
  //này giúp tránh rò rỉ tài nguyên và tiết kiệm tài nguyên máy tính.
  @override
  void dispose() {
    animationController
        .dispose(); //Giải phóng tài nguyên của AnimationController
    super.dispose();
  }

  void onSelectCategory(BuildContext context, Category category) {
    final filterMeal = widget.availableMeal.where((meal) {
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
    return AnimatedBuilder(
        animation: animationController,
        child: GridView(
            padding: const EdgeInsets.all(16),
            gridDelegate: //cấu hình cách các phần tử trong grid được sắp xếp và thay đổi kích thước.
                const SliverGridDelegateWithFixedCrossAxisCount(
              //tạo một grid với số cột cố định
              crossAxisCount: 2, //Số cột trong grid
              childAspectRatio:
                  3 / 2, //Tỷ lệ chiều rộng/chiều cao của mỗi phần tử
              crossAxisSpacing:
                  20, //Khoảng cách giữa các phần tử theo chiều ngang
              mainAxisSpacing:
                  20, // Khoảng cách giữa các phần tử theo chiều dọc
            ),
            children: [
              ...availableCategories.map(
                (category) {
                  return CategoryGridItem(
                    category: category,
                    onSelectCategory: () {
                      return onSelectCategory(context, category);
                    },
                  );
                },
              ).toList()
            ]),
        builder: (context, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.ease,         //xác định đường cong thời gian (timing curve) cho một hoạt ảnh (animation)
              ),
            ),
            child: child,
          );
        });
  }
}
