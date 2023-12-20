import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shopping_app/models/category.dart';
import 'package:shopping_app/style.dart';
import 'package:http/http.dart' as http;

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() {
    return _NewCategoryState();
  }
}

class _NewCategoryState extends State<NewCategory> {
  //Tạo 1 form key cho form thêm loại sp để quản lý
  final formKeyCategory = GlobalKey<FormState>();
  //Khai báo màu ban đầu cho loại sản phẩm
  Color pickerColor = const Color(0xff443a49);
  String enteredCategoryName = '';

  //Hàm thay đổi màu sắc khi người dùng chọn
  void changeColor(Color color) {
    //Cập nhật lại UI
    setState(() {
      pickerColor = color;
    });
  }

  //Hàm nút thêm loại sản phẩm
  void buttonAddCategory() async {
    //Kiểm tra validate(), nếu thỏa mãn điều kiện thì thực hiện bước tiếp theo
    if (formKeyCategory.currentState!.validate()) {
      //Lưu lại trạng thái của textformfield
      formKeyCategory.currentState!.save();

      //Chuyển đổi kiểu dữ liệu color sang chuỗi hex
      //.toRadixString(16) phương thức chuyển đổi, với 16 là một số nguyên chỉ định hệ cơ số, và là hệ thập lục phân
      String stringPickerColor =
          pickerColor.value.toRadixString(16).toUpperCase();

      final url = Uri.https(
          'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
          'viet-fresh-user2/categories.json');
      //http.post - yêu cầu đẩy dữ liệu lên server
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': enteredCategoryName,
            'color': stringPickerColor,
          }));

      if (!context.mounted) {
        return;
      }
      //tạo bản đồ resData bằng cách giải mãi response.body
      final Map<String, dynamic> resData = json.decode(response.body);
      Navigator.of(context).pop(
        Category(
          id: resData['name'],
          name: enteredCategoryName,
          color: pickerColor,
        ),
      );
    }
  }

  String? validatorCategoryName(value) {
    if (value == null || value.isEmpty) {
      return 'Tên loại sản phẩm rỗng';
    }
    //Kiểm tra tên sản phẩm sau khi loại bỏ khoảng trắng có chứa ít nhất 3 kí tự
    else if (value.trim().length < 3) {
      return 'Tên loại sản phẩm phải có ít nhất 3 ký tự';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm loại sản phẩm'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKeyCategory,
            child: Column(
              children: [
                ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                  //Tắt chế độ alpha
                  enableAlpha: false,
                  //Tắt chết độ RGB
                  labelTypes: const [],
                ),
                Text(
                  'Mã màu: ${pickerColor.value.toRadixString(16).toUpperCase()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                    label: Text(
                      'Tên loại sản phẩm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  validator: validatorCategoryName,
                  onSaved: (value) {
                    enteredCategoryName = value!;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: buttonAddCategory,
                      style: ButtonStyle(
                        //Thay đổi màu nền của button theo màu theme đã khai báo
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColorLight,
                        ),
                      ),
                      child: const Style(
                        outputText: 'Thêm loại sản phẩm',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
