// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shopping_app/data/categories.dart';
// import 'package:shopping_app/models/category.dart';
// import 'package:shopping_app/models/grocery_item.dart';
// import 'package:shopping_app/provider/load_category.dart';
// import 'package:shopping_app/style.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// class UpdateItem extends ConsumerStatefulWidget {
//   const UpdateItem({super.key, required this.product});

//   final GroceryItem product;

//   @override
//   ConsumerState<UpdateItem> createState() {
//     return _UpdateItemState();
//   }
// }

// class _UpdateItemState extends ConsumerState<UpdateItem> {
//   final formKey = GlobalKey<FormState>();
//   String? updateNote = '';
//   String updateTenSp = '';
//   int updateSoluongSp = 1;
//   Category? updateLoaiSp;
//   //Biến trạng thái "isUpdating" cho thấy quá trình cập nhật chưa diễn ra
//   var isUpdating = false;

//   //Hàm initState() chỉ được gọi 1 lần và dùng trong trường hợp gọi lại giá trị ban đầu
//   @override
//   void initState() {
//     super.initState();
//     //widget: Là tham chiếu đến instance của StatefulWidget mà State này đang quản lý.
//     updateNote = widget.product.note ?? '';
//     updateTenSp = widget.product.name;
//     updateSoluongSp = widget.product.quantity;
//     updateLoaiSp = widget.product.category;
//   }

//   //Hàm validator kiểm tra tên sản phẩm
//   String? validatorNameProduct(value) {
//     if (value == null || value.isEmpty) {
//       return 'Tên sản phẩm rỗng';
//     }
//     //Kiểm tra tên sản phẩm sau khi loại bỏ khoảng trắng có chứa ít nhất 3 kí tự
//     else if (value.trim().length < 3) {
//       return 'Tên sản phẩm phải có ít nhất 3 ký tự';
//     }
//     //trả về null nếu không có lỗi
//     return null;
//   }

//   //Hàm validator kiểm tra số lượng sản phẩm
//   String? validatorQuantityProduct(value) {
//     if (value == null || value.isEmpty) {
//       return 'Số lượng sản phẩm rỗng';
//     }
//     //int.tryParse convert chuyển đổi chuỗi thành 1 số nguyên
//     else if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
//       return 'Số lượng phải lớn hơn 0';
//     }
//     //trả về null nếu không có lỗi
//     return null;
//   }

//   //Hàm validator kiểm tra loại sản phẩm
//   String? validatorCategoryProduct(value) {
//     if (value == null) {
//       return 'Loại sản phẩm rỗng';
//     }
//     //trả về null nếu không có lỗi
//     return null;
//   }

//   void onSelectedLoaisp(value) {
//     setState(() {
//       updateLoaiSp = value!;
//     });
//   }

//   void buttonUpdateProduct() async {
//     //kiểm tra trạng thái của form thông qua valiedate() các formField
//     if (formKey.currentState!.validate()) {
//       //Nếu đúng thì lưu lại
//       formKey.currentState!.save();
//       setState(() {
//         isUpdating = true;
//       });
//       final url = Uri.https(
//           'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
//           'viet-fresh-user2/products/${widget.product.id}.json');
//       ////http.put -- yêu cầu cập nhật dữ liệu từ firebase
//       final response = await http.put(url,
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode({
//             'name': updateTenSp,
//             'quantity': updateSoluongSp,
//             'category': updateLoaiSp!.name,
//             'note': updateNote,
//           }));
//       if (!context.mounted) return;
//       //Kiểm tra trạng thái response = 200 không
//       if (response.statusCode == 200) {
//         //Đóng màn hình cập nhật sản phẩm sau khi cập nhật sản phẩm xong
//         Navigator.of(context).pop(GroceryItem(
//           id: widget.product.id,
//           name: updateTenSp,
//           quantity: updateSoluongSp,
//           category: updateLoaiSp!,
//           note: updateNote,
//         ));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categories = ref.watch(loadCategoryProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cập nhật sản phẩm'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: updateTenSp,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//                 decoration: const InputDecoration(
//                   //style lại thông báo lỗi của validator
//                   errorStyle: TextStyle(color: Colors.red),
//                   //Thêm viền xung quanh
//                   border: OutlineInputBorder(),
//                   label: Text(
//                     'Tên sản phẩm',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 validator: validatorNameProduct,
//                 onSaved: (value) {
//                   updateTenSp = value!;
//                 },
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                       initialValue: updateSoluongSp.toString(),
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         //style lại thông báo lỗi của validator
//                         errorStyle: TextStyle(color: Colors.red),
//                         //Thêm viền xung quanh
//                         border: OutlineInputBorder(),
//                         label: Text(
//                           'Số lượng',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       validator: validatorQuantityProduct,
//                       //lưu giá trị của field
//                       onSaved: (value) {
//                         updateSoluongSp = int.parse(value!);
//                       },
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   Expanded(
//                     //thay đổi màu nền của dropdown khi nhấn vào
//                     child: Theme(
//                       data: Theme.of(context).copyWith(
//                           canvasColor:
//                               Theme.of(context).scaffoldBackgroundColor),
//                       child: DropdownButtonFormField(
//                         value: updateLoaiSp,
//                         validator: validatorCategoryProduct,
//                         decoration: const InputDecoration(
//                           errorStyle: TextStyle(color: Colors.red),
//                           //Thêm viền xung quanh
//                           border: OutlineInputBorder(),
//                           label: Text(
//                             'Loại sản phẩm',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ),
//                         items: categories.map((category) {
//                           return DropdownMenuItem(
//                             value: category,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 16,
//                                   height: 16,
//                                   color: category.color,
//                                 ),
//                                 const SizedBox(
//                                   width: 6,
//                                 ),
//                                 Style(outputText: category.name)
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             updateLoaiSp = value!;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 initialValue: updateNote,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//                 decoration: const InputDecoration(
//                     label: Text(
//                       'Ghi chú',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     //Thêm viền xung quanh
//                     border: OutlineInputBorder()),
//                 //Độ dài tối đa ghi chú
//                 maxLength: 200,
//                 //Số dòng tối đa
//                 maxLines: 5,
//                 onSaved: (value) {
//                   updateNote = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                       onPressed: isUpdating ? null : buttonUpdateProduct,
//                       style: ButtonStyle(
//                         //Thay đổi màu nền của button theo màu theme đã khai báo
//                         backgroundColor: MaterialStateProperty.all(
//                           Theme.of(context).primaryColorLight,
//                         ),
//                       ),
//                       child: isUpdating
//                           ? const SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(),
//                             )
//                           : const Style(outputText: "Cập nhật sản phẩm")),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
