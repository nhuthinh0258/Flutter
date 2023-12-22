import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({super.key, required this.onSelectedProductImage});

  final void Function(File image) onSelectedProductImage;
  @override
  State<ProductImage> createState() {
    return _ProductImageState();
  }
}

class _ProductImageState extends State<ProductImage> {
  File? selectedImage;
  var isLoadImage = true;

  void pickCategoryImage() async {
    final pickedCategoryImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 200);
    setState(() {
      isLoadImage = true;
    });
    if (pickedCategoryImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedCategoryImage.path);
      isLoadImage = false;
    });
    widget.onSelectedProductImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: pickCategoryImage,
      icon: const Icon(Icons.camera),
      label: const Text('Chọn ảnh'),
    );

    //Nếu selectedImage ko phải null, tạo widget để hiển thị ảnh đấy
    if (selectedImage != null) {
      content = isLoadImage
          ? const CircularProgressIndicator()
          : GestureDetector(
              onTap: pickCategoryImage,
              child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
      ),
      width: double.infinity,
      height: 250,
      alignment: Alignment.center,
      child: content,
    );
  }
}
