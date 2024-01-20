import 'dart:io';

import 'package:flutter/material.dart';

import '../style.dart';
import '../widget/category_image.dart';
import 'auth_admin.dart';
import 'new_category.dart';

class UpdateCategories extends StatefulWidget {
  const UpdateCategories(
      {super.key, required this.categories, required this.currentImageUrl});
  final Map<String, dynamic> categories;
  final String currentImageUrl;

  @override
  State<UpdateCategories> createState() {
    return _UpdateCategoriesState();
  }
}

class _UpdateCategoriesState extends State<UpdateCategories> {
  final formKeyUpdateCategories = GlobalKey<FormState>();
  var enteredNameCategories = '';
  File? selectedImage;
  var isSending = false;

  @override
  void initState() {
    super.initState();
    enteredNameCategories = widget.categories['name'];
  }

  void updateCategory() async {
    if (formKeyUpdateCategories.currentState!.validate()) {
      formKeyUpdateCategories.currentState!.save();

      setState(() {
        isSending = true;
      });
      //Lưu ảnh hiện tại vào imageUrl
      String imageUrl = widget.currentImageUrl;

      //Nếu việc thay ảnh là đúng
      if (selectedImage != null) {
        //Lưu ảnh cũ vào biến oldImageUrl
        String oldImageUrl = imageUrl;
        //Tạo id ảnh sản phẩm mới
        final categoryImage =
            'category-${DateTime.now().millisecondsSinceEpoch}.jpg';
        //Lưu ảnh vào product_image trong firestorage
        final storageRef =
            firebaseStorage.ref().child('category_image').child(categoryImage);
        //Đợi lưu ảnh
        await storageRef.putFile(selectedImage!);
        //Đợi lấy url của ảnh sau khi lưu
        imageUrl = await storageRef.getDownloadURL();
        //Nếu ảnh cũ khác với ảnh mới
        if (oldImageUrl != imageUrl) {
          //Xóa ảnh cũ
          firebaseStorage.refFromURL(oldImageUrl).delete();
        }
      }
      final categoryId = widget.categories['category_id'];
      await firestore.collection('category').doc(categoryId).update({
        'image': imageUrl,
        'name': enteredNameCategories,
      });
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  void onSelectedCategoryImage(File image) {
    selectedImage = image;
  }

  String? validatorEnteredNameCategory(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 3) {
      return 'Tên sản phẩm ko hợp lệ';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKeyUpdateCategories,
            child: Column(
              children: [
                CategoryImage(
                  onSelectedCategoryImage: onSelectedCategoryImage,
                  initialImageUrl: widget.categories['image'],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: enteredNameCategories,
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                    label: Text(
                      'Tên sản phẩm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  validator: validatorEnteredNameCategory,
                  onSaved: (value) {
                    enteredNameCategories = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: updateCategory,
                      style: ButtonStyle(
                        //Thay đổi màu nền của button theo màu theme đã khai báo
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColorLight,
                        ),
                      ),
                      child: isSending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const Style(
                              outputText: 'Sửa sản phẩm',
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
