import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/models/category.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/style.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem({super.key, required this.product});

  final GroceryItem product;

  @override
  State<UpdateItem> createState() {
    return _UpdateItemState();
  }
}

class _UpdateItemState extends State<UpdateItem> {
  final formKey = GlobalKey<FormState>();
  var updateNote = '';
  var updateTenSp = '';
  var updateSoluongSp = 1;
  Category? updateLoaiSp;

  //Hàm initState() chỉ được gọi 1 lần và dùng trong trường hợp gọi lại giá trị ban đầu
  @override
  void initState() {
    super.initState();
    //widget: Là tham chiếu đến instance của StatefulWidget mà State này đang quản lý.
    updateNote = widget.product.note ?? '';
    updateTenSp = widget.product.name;
    updateSoluongSp = widget.product.quantity;
    updateLoaiSp = widget.product.category;
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
      updateLoaiSp = value!;
    });
  }

  void buttonUpdateProduct() {
    //kiểm tra trạng thái của form thông qua valiedate() các formField
    if (formKey.currentState!.validate()) {
      //Nếu đúng thì lưu lại
      formKey.currentState!.save();
      //Đóng màn hình cập nhật sản phẩm sau khi cập nhật sản phẩm xong
      Navigator.of(context).pop(GroceryItem(
        id: widget.product.id,
        name: updateTenSp,
        quantity: updateSoluongSp,
        category: updateLoaiSp!,
        note: updateNote,
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật sản phẩm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: updateTenSp,
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
                  updateTenSp = value!;
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
                      initialValue: updateSoluongSp.toString(),
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
                        updateSoluongSp = int.parse(value!);
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
                        value: updateLoaiSp,
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
                        items: [
                          //Cách 1:
                          // for (final category in categories.entries)
                          //   DropdownMenuItem(
                          //       value: category.value,
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             width: 16,
                          //             height: 16,
                          //             color: category.value.color,
                          //           ),
                          //           const SizedBox(
                          //             width: 6,
                          //           ),
                          //           Style(outputText: category.value.name),
                          //         ],
                          //       ),
                          //     );
                          //Cách 2:
                          ...categories.entries.map(
                            (category) {
                              return DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Style(outputText: category.value.name),
                                  ],
                                ),
                              );
                            },
                          ).toList()
                        ],
                        onChanged: (value) {
                          setState(() {
                            updateLoaiSp = value!;
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
                initialValue: updateNote,
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
                  updateNote = value!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: buttonUpdateProduct,
                    style: ButtonStyle(
                      //Thay đổi màu nền của button theo màu theme đã khai báo
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorLight,
                      ),
                    ),
                    child: const Style(
                      outputText: 'Cập nhật sản phẩm',
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
