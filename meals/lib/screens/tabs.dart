import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

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

  void messageMeal(String message) {
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //xóa tất cả các snack bar đang hiển thị trong Scaffold hiện tại.
    ScaffoldMessenger.of(context).showSnackBar(//hiển thị thông báo tạm thời (snack bar) cho người dùng
      SnackBar(
        duration:const Duration(seconds: 4),//Thời gian hiển thị 5s
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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
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
