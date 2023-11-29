import 'package:flutter/material.dart';

import 'package:meals/model/meal.dart';
import 'package:meals/screens/detail.dart';
import 'package:meals/widget/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.meals, this.title});

  final String? title; //title có thể nhận giá trị String hoặc null.
  final List<Meal> meals;

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((ctx) {
          return DetailScreen(
            meal: meal,
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget meal(context, index) {
      return MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          onSelectMeal(context, meal);
        },
      );
    }

    //Nếu không có món ăn nào thì hiển thị thông báo hiện không có gì
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hiện không có món nào!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75)),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Thử chọn lại các danh mục khác',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75)),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        //xây dựng danh sách dựa trên một danh sách dữ liệu và builder function
        itemBuilder: meal,
        itemCount: meals.length,
      );
    }

    if (title == null) {
      //trường hợp title là null, nó sẽ trả về content và không tiếp tục xử lý các phần code phía dưới
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!), //title sẽ ko bao giờ null
      ),
      body: content,
    );
  }
}
