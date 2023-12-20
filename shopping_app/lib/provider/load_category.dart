import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/models/category.dart';
import 'package:http/http.dart' as http;

class LoadCategoryNotifier extends StateNotifier<List<Category>> {
  LoadCategoryNotifier() : super([]);

  // void loadCategory() async {
  //   final url = Uri.https(
  //       'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
  //       'viet-fresh-user2/categories.json');
  //   //http.get - yêu cầu lấy dữ liệu từ server
  //   final response = await http.get(url);
  //   // kiểm tra xem phản hồi từ server có phải là chuỗi 'null' không
  //   if (response.body == 'null') {
  //     //ếu đúng, cập nhật trạng thái isLoading thành false để ngừng hiển thị bộ chỉ báo tải (loading
  //     //Kết thúc hàm ngay lập tức nếu đúng, giúp ngăn chặn thực thi các dòng code phía dưới
  //     return;
  //   }
  //   final Map<String, dynamic> resData = json.decode(response.body);
  //   //Duyệt từng bản ghi trong resData rồi xuất ra danh sách
  //   final List<Category> mapCategory = resData.entries.map((category) {
  //     //Khởi tạo chuỗi hexColor dựa trên giá trị color trong database
  //     String hexColor = category.value['color'];
  //     //Ép kiểu int intcolor từ chuỗi hexColor, với radix 16 là chuỗi hệ thập lục phân
  //     int intColor = int.parse(hexColor, radix: 16);
  //     //Khởi tạo Color dựa trên giá trị intColor
  //     Color color = Color(intColor + 0xFF000000);
  //     return Category(
  //       id: category.key,
  //       name: category.value['name'],
  //       color: color,
  //     );
  //   }).toList();

  //   //Cập nhật UI sau khi load dữ liệu
  //   state = mapCategory;
  // }
  Future<List<Category>> loadCategory() async {
    final url = Uri.https(
        'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'viet-fresh-user2/categories.json');
    final response = await http.get(url);

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> resData = json.decode(response.body);
    final List<Category> mapCategory = resData.entries.map((category) {
      String hexColor = category.value['color'];
      int intColor = int.parse(hexColor, radix: 16);
      Color color = Color(intColor + 0xFF000000);
      return Category(
        id: category.key,
        name: category.value['name'],
        color: color,
      );
    }).toList();

    state = mapCategory;
    return mapCategory;
  }
}

final loadCategoryProvider =
    StateNotifierProvider<LoadCategoryNotifier, List<Category>>((ref) {
      return LoadCategoryNotifier();
});

// final loadCategoryProvider =
//     StateNotifierProvider<LoadCategoryNotifier, List<Category>>((ref) {
//   var notifier = LoadCategoryNotifier();
//   notifier.loadCategory(); // Đảm bảo rằng hàm này được gọi
//   return notifier;
// });