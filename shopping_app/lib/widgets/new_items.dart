import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/style.dart';

class NewItems extends StatelessWidget {
  const NewItems({super.key});

  //Hàm validator kiểm tra tên sản phẩm
  String? validatorNameProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Tên sản phẩm chưa được nhập';
    }
    //Kiểm tra tên sản phẩm sau khi loại bỏ khoảng trắng có chứa ít nhất 3 kí tự
    else if (value.trim() <= 2) {
      return 'Tên sản phẩm phải có ít nhất 3 ký tự';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  //Hàm validator kiểm tra số lượng sản phẩm
  String? validatorQuantityProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Số lượng sản phẩm chưa được nhập';
    } 
    //int.tryParse convert chuyển đổi chuỗi thành 1 số nguyên
    else if (int.tryParse(value) == null || int.tryParse(value)! <=0) {
      return 'Số lượng sản phẩm phải lớn hơn 0';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  //Hàm validator kiểm tra loại sản phẩm
  // String? validatorCategoryProduct(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Loại sản phẩm chưa được chọn';
  //   }
  //   //trả về null nếu không có lỗi
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                ///Thêm viền xung quanh
                border: OutlineInputBorder(),
                label: Text(
                  'Tên sản phẩm',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              validator: validatorNameProduct,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      ////Thêm viền xung quanh
                      border: OutlineInputBorder(),
                      label: Text(
                        'Số lượng',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    validator: validatorQuantityProduct,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  //thay đổi màu nền của dropdown khi nhấn vào
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: Theme.of(context).scaffoldBackgroundColor),
                    child: DropdownButtonFormField(
                      // validator: validatorCategoryProduct,
                      decoration: const InputDecoration(
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
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
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
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Style(
                    outputText: 'Clear',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    //Thay đổi màu nền của button theo màu theme đã khai báo
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight,
                    ),
                  ),
                  child: const Style(
                    outputText: 'Thêm sản phẩm',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
