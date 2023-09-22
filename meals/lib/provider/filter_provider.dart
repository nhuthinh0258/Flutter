import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/filters.dart';

enum Filter {
  //enum là một kiểu dữ liệu đặc biệt dùng để định nghĩa một tập hợp các hằng số (constants) có tên
  GlutenFree,
  LactoseFree, //Hằng số
  Vegan,
  Vegetarian,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  ////Hàm tạo đặt trạng thái ban đầu
  FilterNotifier()
      : super({
          Filter.GlutenFree: false,
          Filter.LactoseFree: false,
          Filter.Vegetarian: false,
          Filter.Vegan: false,
        });
  void setFilters(Map<Filter,bool> ChosenFilters){
    state = ChosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterNotifier = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) {
    return FilterNotifier();
  },
);
