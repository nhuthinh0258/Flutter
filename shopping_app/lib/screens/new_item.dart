import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/models/category.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/provider/load_category.dart';
import 'package:shopping_app/style.dart';
import 'package:http/http.dart' as http;

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});
  @override
  ConsumerState<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends ConsumerState<NewItem> {
  //GlobalKey<FormState>, được sử dụng để duy trì trạng thái của Form. Nó cho phép truy cập vào trạng thái của Form từ bất kỳ đâu
  //trong widget tree
  final formKey = GlobalKey<FormState>();
  String? enteredNote = '';
  String enteredTenSp = '';
  int enteredSoluongSp = 1;
  Category? selectedLoaiSp;
  //Biến trạng thái "isSending" cho thấy quá trình gửi chưa diễn ra
  var isSending = false;

  //Xử lý nút thêm sản phẩm
  //Khi một hàm được đánh dấu là async, nó tự động trả về một Future
  //async: Cho biết hàm "buttonAddProduct" sẽ thực hiện các hoạt động bất đồng bộ
  void buttonAddProduct() async {
    //kiểm tra trạng thái của form thông qua valiedate() các formField
    if (formKey.currentState!.validate()) {
      //Nếu đúng thì lưu lại
      formKey.currentState!.save();
      //Quản lý trạng thái gửi
      setState(() {
        isSending = true;
      });
      //Địa chỉ URL mà ta muốn gửi yêu cầu POST đến.
      final url = Uri.https(
          'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
          'viet-fresh-user2/products.json');
      // await http.post(..) Chờ đợi Future hoàn thành và trả về Response, sau đó mới tiếp tục các dòng lệnh khách
      //http.post -- Yêu cầu gửi dữ liệu lên firebase
      final response = await http.post(url,
          //Định nghĩa loại nội dung bạn đang gửi, thường là application/json
          headers: {'Content-Type': 'application/json'},
          // Dữ liệu bạn muốn gửi, được mã hóa dưới dạng JSON.
          body: json.encode({
            'name': enteredTenSp,
            'quantity': enteredSoluongSp,
            'category': selectedLoaiSp!.id,
            'note': enteredNote,
          }));

      //mounted là một thuộc tính của State trong StatefulWidget. Nó trả về true nếu đối tượng State hiện tại vẫn được gắn vào cây
      //widget (nghĩa là widget vẫn được hiển thị trên màn hình và chưa bị hủy)

      //if (!context.mounted) return; đảm bảo rằng nếu widget không còn tồn tại (ví dụ: người dùng đã rời khỏi màn hình), thì hàm sẽ
      //kết thúc ngay lập tức và không thực hiện các lệnh tiếp theo, bảo vệ ứng dụng khỏi lỗi liên quan đến việc cố gắng cập nhật một
      //widget không còn tồn tại.
      if (!context.mounted) {
        return;
      }
      final Map<String, dynamic> resData = json.decode(response.body);
      //Đóng màn hình thêm sản phẩm sau khi thêm sản phẩm xong
      Navigator.of(context).pop(GroceryItem(
          id: resData['name'],
          name: enteredTenSp,
          quantity: enteredSoluongSp,
          category: selectedLoaiSp!,
          note: enteredNote));
    }
  }

  //Hàm validator kiểm tra tên sản phẩm
  String? validatorNameProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Tên sản phẩm rỗng';
    }
    //Kiểm tra tên sản phẩm sau khi loại bỏ khoảng trắng có chứa ít nhất 3 kí tự
    else if (value.trim().length < 3) {
      return 'Tên sản phẩm phải có ít nhất 3 ký tự';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  //Hàm validator kiểm tra số lượng sản phẩm
  String? validatorQuantityProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Số lượng sản phẩm rỗng';
    }
    //int.tryParse convert chuyển đổi chuỗi thành 1 số nguyên
    else if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
      return 'Số lượng phải lớn hơn 0';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  //Hàm validator kiểm tra loại sản phẩm
  String? validatorCategoryProduct(value) {
    if (value == null) {
      return 'Loại sản phẩm rỗng';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  void onSelectedLoaisp(value) {
    setState(() {
      selectedLoaiSp = value!;
    });
  }

  void buttonClearProduct() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(loadCategoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  //style lại thông báo lỗi của validator
                  errorStyle: TextStyle(color: Colors.red),
                  //Thêm viền xung quanh
                  border: OutlineInputBorder(),
                  label: Text(
                    'Tên sản phẩm',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                validator: validatorNameProduct,
                onSaved: (value) {
                  enteredTenSp = value!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        //style lại thông báo lỗi của validator
                        errorStyle: TextStyle(color: Colors.red),
                        //Thêm viền xung quanh
                        border: OutlineInputBorder(),
                        label: Text(
                          'Số lượng',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      validator: validatorQuantityProduct,
                      //lưu giá trị của field
                      onSaved: (value) {
                        enteredSoluongSp = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    //thay đổi màu nền của dropdown khi nhấn vào
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor:
                              Theme.of(context).scaffoldBackgroundColor),
                      child: DropdownButtonFormField(
                        value: selectedLoaiSp,
                        validator: validatorCategoryProduct,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          //Thêm viền xung quanh
                          border: OutlineInputBorder(),
                          label: Text(
                            'Loại sản phẩm',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Style(outputText: category.name)
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLoaiSp = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                    label: Text(
                      'Ghi chú',
                      style: TextStyle(fontSize: 20),
                    ),
                    //Thêm viền xung quanh
                    border: OutlineInputBorder()),
                //Độ dài tối đa ghi chú
                maxLength: 200,
                //Số dòng tối đa
                maxLines: 5,
                onSaved: (value) {
                  enteredNote = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSending ? null : buttonClearProduct,
                    child: const Style(
                      outputText: 'Clear',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isSending ? null : buttonAddProduct,
                    style: ButtonStyle(
                      //Thay đổi màu nền của button theo màu theme đã khai báo
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorLight,
                      ),
                    ),
                    child: isSending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Style(
                            outputText: 'Thêm sản phẩm',
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
