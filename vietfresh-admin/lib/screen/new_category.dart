import 'dart:io';

import 'package:admin/screen/auth_admin.dart';
import 'package:admin/style.dart';
import 'package:admin/widget/category_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final firebaseStorage = FirebaseStorage.instance;

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() {
    return _NewCategoryState();
  }
}

class _NewCategoryState extends State<NewCategory> {
  final formkeyCategory = GlobalKey<FormState>();
  var enteredNameCategory = '';
  File? selectedImage;
  var isSending = false;

  void submitCategory() async {
    if (formkeyCategory.currentState!.validate()) {
      if (selectedImage == null) {
        return;
      }
      formkeyCategory.currentState!.save();

      setState(() {
        isSending = true;
      });

      final categoryId =
          'category-${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef =
          firebaseStorage.ref().child('category_image').child(categoryId);
      await storageRef.putFile(selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await firestore.collection('category').doc(categoryId).set({
        'image': imageUrl,
        'name': enteredNameCategory,
      });
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }
  }

  void onSelectedCategoryImage(File image) {
    selectedImage = image;
  }

  String? validatorEnteredNameCategory(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 3) {
      return 'Tên loại sản phẩm ko hợp lệ';
    }
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
            key: formkeyCategory,
            child: Column(
              children: [
                CategoryImage(
                  onSelectedCategoryImage: onSelectedCategoryImage,
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
                  validator: validatorEnteredNameCategory,
                  onSaved: (value) {
                    enteredNameCategory = value!;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: submitCategory,
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
