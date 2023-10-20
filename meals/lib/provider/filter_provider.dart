import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meal_provider.dart';

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
  
  //đặt các giá trị ban đầu là false cho tất cả các filter trong trường hợp bạn muốn khi khởi tạo ứng dụng hoặc cần thiết để đặt lại 
  //trạng thái filter về giá trị mặc định.
  void setFilters(Map<Filter,bool> ChosenFilters){
    state = ChosenFilters;
  }

  //đặt giá trị isActive cho một filter cụ thể trong trạng thái (state) của ứng dụng. Nếu gọi hàm này với một filter cụ thể và giá trị 
  //true, nó sẽ đặt filter đó thành "được kích hoạt" hoặc true. Nếu gọi hàm này với giá trị false, nó sẽ đặt filter đó thành "không 
  //được kích hoạt" hoặc false.
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

final filteredMealProvider = Provider((ref) {
  final meals=ref.watch(mealProvider);  // sử dụng ref.watch() để theo dõi sự thay đổi của provider mealProvider và lấy giá trị hiện tại của nó.
  final activeFilters = ref.watch(filterNotifier);  // sử dụng ref.watch() để theo dõi sự thay đổi của provider filterNotifier và lấy giá trị hiện tại của nó.

  //Phương thức where lọc danh sách meal theo từng điều kiện
  return meals.where((meal) {
      //Kiểm tra xem bộ lọc selectedFilter[Filter.GlutenFree] đã được đặt hay chưa và kiểm tra meal có thuộc tính là true hay
      // false (nếu meal.isGlutenFree là true và !meal.isGlutenFree là false)
      if (activeFilters[Filter.GlutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.LactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.Vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.Vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
});
