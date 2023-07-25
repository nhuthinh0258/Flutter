import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widget/drawer_main.dart';
import 'package:meals/data/dummy_data.dart';

const kInitialFilter = {
  Filter.GlutenFree: false,
  Filter.LactoseFree: false,
  Filter.Vegetarian: false,
  Filter.Vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex =
      0; //giá trị mặc định của biến selectedPageIndex là 0. Điều này có nghĩa là trang đầu tiên sẽ được chọn mặc định khi ứng dụng khởi chạy.
  final List<Meal> mealFavorite = []; //Tạo một danh sách mealFavorite rỗng
  
  //selectedFilter sẽ lưu trữ các bộ lọc có kiểu Filter (được định nghĩa từ enum Filter), và mỗi bộ lọc sẽ có giá trị bool 
  //tương ứng (được đánh giá bởi true hoặc false)
  //selectedFilter sẽ ban đầu có giá trị là một Map chứa tất cả các bộ lọc, và tất cả các bộ lọc đều được đánh giá là false, 
  //tức là người dùng chưa chọn bất kỳ bộ lọc nào. Sau đó, khi người dùng thực hiện chọn các bộ lọc, giá trị của 
  //selectedFilter sẽ thay đổi tương ứng để thể hiện việc chọn bộ lọc của người dùng
  Map<Filter, bool> selectedFilter = kInitialFilter;

  void messageMeal(String message) {
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //xóa tất cả các snack bar đang hiển thị trong Scaffold hiện tại.
    ScaffoldMessenger.of(context).showSnackBar(
      //hiển thị thông báo tạm thời (snack bar) cho người dùng
      SnackBar(
        duration: const Duration(seconds: 4), //Thời gian hiển thị 5s
        content: Text(message),
      ),
    );
  }

  void toggleFavoriteMealStatus(Meal meal) {
    final isExisting = mealFavorite.contains(
        meal); //kiểm tra xem món ăn meal có tồn tại trong danh sách mealFavorite hay không.
    //Kết quả của phương thức contains() là true nếu món ăn meal được tìm thấy trong danh sách mealFavorite, và false nếu không tìm thấy.

    setState(() {
      if (isExisting == true) {
        mealFavorite.remove(
            meal); // Nếu món ăn đã tồn tại trong danh sách yêu thích, hãy loại bỏ nó
        messageMeal('Đã xóa món ăn khỏi danh sách yêu thích');
      } else {
        mealFavorite.add(
            meal); // Nếu món ăn chưa tồn tại trong danh sách yêu thích, hãy thêm nó vào
        messageMeal('Đã thêm món ăn vào danh sách yêu thích');
      }
    });
  }

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

      final result = await Navigator.push<Map<Filter, bool>>(
        //phương thức trong Flutter để chuyển đổi giữa các màn hình (routes) trong ứng dụng
        context,
        MaterialPageRoute(
          // widget trong Flutter được sử dụng để xác định một màn hình mới trong ứng dụng
          builder: ((ctx) {
            return FilterScreen(currentFilter: selectedFilter);
          }),
        ),
      );
      setState(() {
        //toán tử ?? sẽ kiểm tra xem result có null hay không, nếu null thì nó được thay thế bằng giá trị mặc định là null
        //(kInitialFilter), nếu không phải null, giá trị của result được gán cho selectedFilter
        selectedFilter = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Phương thức where lọc danh sách meal theo từng điều kiện
    final availableMeal = dummyMeals.where((meal) {
      //Kiểm tra xem bộ lọc selectedFilter[Filter.GlutenFree] đã được đặt hay chưa và kiểm tra meal có thuộc tính là true hay
      // false (nếu meal.isGlutenFree là true thì !meal.isGlutenFree là false)
      if (selectedFilter[Filter.GlutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilter[Filter.LactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilter[Filter.Vegan]! && !meal.isVegan) {
        return false;
      }
      if (selectedFilter[Filter.Vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(
      availableMeal: availableMeal,
      onToggleFavorite: toggleFavoriteMealStatus,
    );
    var activePageTitle = 'Select category you want';

    if (selectedPageIndex == 1) {
      //Nếu selectedPageIndex có giá trị bằng 1, nghĩa là người dùng đã chọn trang "Favorites"
      activePage = MealScreen(
        meals: mealFavorite,
        onToggleFavorite: toggleFavoriteMealStatus,
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
