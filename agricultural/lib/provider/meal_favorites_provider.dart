
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

class MealFavoritesNotifier extends StateNotifier<List<Meal>> {
  MealFavoritesNotifier() : super([]);  //Hàm tạo đặt trạng thái ban đầu

  bool toggleFavoriteMealStatus(Meal meal) {
    final mealIsFavorites = state.contains(meal);

    // trường hợp meal đã tồn tại trong danh sách yêu thích
    if (mealIsFavorites == true) {
      state = state.where((m){
        return m.id != meal.id;
      }).toList();
      return false;
    }
    // trường hợp meal chưa tồn tại trong danh sách yêu thích  
    else {
      //biến state sau khi thực hiện dòng mã này sẽ chứa danh sách cũ và một món ăn mới meal.
      state = [...state,meal];
      return true;
    }
  }
}

final mealFavoritesNotifier = StateNotifierProvider<MealFavoritesNotifier, List<Meal>>((ref) {
  return MealFavoritesNotifier();
},);
