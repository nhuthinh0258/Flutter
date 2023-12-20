import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/screens/new_category.dart';
import 'package:shopping_app/widgets/categories_item.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() {
    return CategoryListState();
  }
}

class CategoryListState extends State<CategoryList> {
  //Khởi tạo danh sách ban đầu
  List<Category> listCategory = [];
  var isLoadingCata = true;

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  //Hàm hiển thị danh mục từ firebase
  void loadCategory() async {
    final url = Uri.https(
        'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'viet-fresh-user2/categories.json');
    //http.get - yêu cầu lấy dữ liệu từ server
    final response = await http.get(url);
    // kiểm tra xem phản hồi từ server có phải là chuỗi 'null' không
    if (response.body == 'null') {
      //ếu đúng, cập nhật trạng thái isLoading thành false để ngừng hiển thị bộ chỉ báo tải (loading
      setState(() {
        isLoadingCata = false;
      });
      //Kết thúc hàm ngay lập tức nếu đúng, giúp ngăn chặn thực thi các dòng code phía dưới
      return;
    }
    final Map<String, dynamic> resData = json.decode(response.body);
    //Duyệt từng bản ghi trong resData rồi xuất ra danh sách
    final List<Category> mapCategory = resData.entries.map((category) {
      //Khởi tạo chuỗi hexColor dựa trên giá trị color trong database
      String hexColor = category.value['color'];
      //Ép kiểu int intcolor từ chuỗi hexColor, với radix 16 là chuỗi hệ thập lục phân
      int intColor = int.parse(hexColor, radix: 16);
      //Khởi tạo Color dựa trên giá trị intColor
      Color color = Color(intColor + 0xFF000000);
      return Category(
        id: category.key,
        name: category.value['name'],
        color: color,
      );
    }).toList();

    //Cập nhật UI sau khi load dữ liệu
    setState(() {
      listCategory = mapCategory;
      isLoadingCata = false;
    });
  }

  //Hàm thêm danh mục
  void addCategory() async {
    //await đợi màn hình NewCategory() đóng rồi trả về kết quản newCategory
    final newCategory = await Navigator.of(context).push<Category>(
      MaterialPageRoute(
        builder: (ctx) {
          return const NewCategory();
        },
      ),
    );
    //Nếu kết quả rỗng, kết thúc luôn, không thực hiện các bước tiếp theo
    if (newCategory == null) {
      return;
    }
    setState(() {
      //Nếu không rỗng, tiến hành thêm loại sp
      listCategory.add(newCategory);
    });
  }

  //Hàm xóa sản phẩm
  void onRemoveCategory(Category category) async {
    final url = Uri.https(
        'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'viet-fresh-user2/categories/${category.id}.json');
    //http.delete - yêu cầu xóa
    final response =await http.delete(url);
    if(response.statusCode == 200){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách loại sản phẩm'),
        actions: [
          IconButton(
            onPressed: addCategory,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: CategoryItem(
        listCategory: listCategory,
        isLoadingCata: isLoadingCata,
      ),
    );
  }
}
