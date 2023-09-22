import 'package:flutter/material.dart';
import 'package:meals/provider/meal_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widget/drawer_main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meal_favorites_provider.dart';
import 'package:meals/provider/filter_provider.dart';

const kInitialFilter = {
  Filter.GlutenFree: false,
  Filter.LactoseFree: false,
  Filter.Vegetarian: false,
  Filter.Vegan: false,
};

//ConsumerStatefulWidget được gọi khi sử dụng Provider
class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int selectedPageIndex =
      0; //giá trị mặc định của biến selectedPageIndex là 0. Điều này có nghĩa là trang đầu tiên sẽ được chọn mặc định khi ứng dụng khởi chạy.

  //selectedFilter sẽ lưu trữ các bộ lọc có kiểu Filter (được định nghĩa từ enum Filter), và mỗi bộ lọc sẽ có giá trị bool
  //tương ứng (được đánh giá bởi true hoặc false)
  //selectedFilter sẽ ban đầu có giá trị là một Map chứa tất cả các bộ lọc, và tất cả các bộ lọc đều được đánh giá là false,
  //tức là người dùng chưa chọn bất kỳ bộ lọc nào. Sau đó, khi người dùng thực hiện chọn các bộ lọc, giá trị của
  //selectedFilter sẽ thay đổi tương ứng để thể hiện việc chọn bộ lọc của người dùng

  void selectedPage(int index) {
    setState(() {
      selectedPageIndex =
          index; //Khi người dùng chọn một trang mới, hàm selectedPage được gọi với tham số là chỉ mục của trang đó.
    });
  }

  //hàm setScreen dùng để chuyển đến màn hình FilterScreen và đợi kết quả trả về từ màn hình đó. Nếu kết quả trả về là null
  //(do người dùng không thực hiện thay đổi gì trong màn hình FilterScreen), thì sau khi màn hình FilterScreen đóng lại,
  //chương trình sẽ tiếp tục thực hiện các lệnh tiếp theo sau if (indentify == 'filters') { ... }. Nếu kết quả trả về không
  //null (do người dùng đã thực hiện thay đổi trong màn hình FilterScreen), thì kết quả đó sẽ được lưu trong biến result và
  //sau đó có thể sử dụng để thực hiện các tác vụ tiếp theo.

  void setScreen(String indentify) async {
    Navigator.pop(
        context); //đóng màn hình hiện tại và trở lại màn hình trước đó
    if (indentify == 'filters') {
      //Map là một cấu trúc dữ liệu giúp lưu trữ các cặp key-value. Mỗi key là duy nhất trong một Map, và nó được sử dụng
      //để truy xuất đến giá trị tương ứng (value). Map<Filter, bool> cho biết rằng trong Map đó, các key là kiểu dữ liệu
      //Filter (được định nghĩa trong enum Filter) và các value là kiểu dữ liệu bool (boolean).

      await Navigator.push<Map<Filter, bool>>(
        //phương thức trong Flutter để chuyển đổi giữa các màn hình (routes) trong ứng dụng
        context,
        MaterialPageRoute(
          // widget trong Flutter được sử dụng để xác định một màn hình mới trong ứng dụng
          builder: ((ctx) {
            return const FilterScreen();
          }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //Phương thức where lọc danh sách meal theo từng điều kiện
    final meals = ref.watch(
        mealProvider); // sử dụng ref.watch() để theo dõi sự thay đổi của provider mealProvider và lấy giá trị hiện tại của nó.
    final activeFilters = ref.watch(filterNotifier);
    final availableMeal = meals.where((meal) {
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

    Widget activePage = CategoryScreen(
      availableMeal: availableMeal,
    );
    var activePageTitle = 'Select category you want';

    if (selectedPageIndex == 1) {
      //Nếu selectedPageIndex có giá trị bằng 1, nghĩa là người dùng đã chọn trang "Favorites"
      final mealFavorite = ref.watch(mealFavoritesNotifier);
      activePage = MealScreen(
        meals: mealFavorite,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: DrawerMain(
        onSelectScreen: setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //tạo một thanh điều hướng dưới cùng (bottom navigation bar) cho ứng dụng của mình
        currentIndex: selectedPageIndex,
        onTap: selectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'), //Tab category
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Favorites'), //Tab favorite
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
