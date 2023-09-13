import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/provider/meal_favorites_provider.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildContainer(Widget child) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              // sử dụng ref.read() để đọc và sử dụng mealFavoritesNotifier.notifier để truy cập vào phương thức
              //toggleFavoriteMealStatus của mealFavoritesNotifier
              final wasAdded = ref
                  .read(mealFavoritesNotifier
                      .notifier) //được sử dụng để truy cập đối tượng "notifier" của provider
                  .toggleFavoriteMealStatus(meal);

              ScaffoldMessenger.of(context)
                  .clearSnackBars(); //xóa tất cả các snack bar đang hiển thị trong Scaffold hiện tại.
              ScaffoldMessenger.of(context).showSnackBar(
                //hiển thị thông báo tạm thời (snack bar) cho người dùng
                SnackBar(

                  content: Text(wasAdded ? 'Thêm thành công vào danh sách' : 'Đã xóa món khỏi danh sách'),
                ),
              );
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double
                  .infinity, //Ảnh sẽ chiếm hết không gian theo chiều ngang nhiều nhất có thể
              fit: BoxFit
                  .cover, //xác định cách hiển thị nội dung của một widget trong một không gian giới hạn, ở đây sẽ được tự động co dãn mà vẫn giữ ti lệ gốc
            ),
            const SizedBox(height: 14),
            buildContainer(
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: 370,
              child: ListView(
                physics:
                    const NeverScrollableScrollPhysics(), //Chặn cuộn lên xuống trong listview
                shrinkWrap:
                    true, //thu gọn kích thước của ListView để phù hợp với kích thước của các phần tử con
                children: [
                  ...meal.ingredients.map(
                    (ingredient) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          ingredient,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
            const SizedBox(height: 14),
            buildContainer(
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 370,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...meal.steps.asMap().entries.map(
                    //Đánh số thứ tự
                    (entry) {
                      final index = entry.key + 1;
                      final step = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: ListTile(
                          title: Text(
                            '$index. $step',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
