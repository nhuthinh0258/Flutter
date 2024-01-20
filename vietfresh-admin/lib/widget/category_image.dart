import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryImage extends StatefulWidget {
  const CategoryImage(
      {super.key,
      required this.onSelectedCategoryImage,
      required this.initialImageUrl});
  final String? initialImageUrl;
  final void Function(File image) onSelectedCategoryImage;
  @override
  State<CategoryImage> createState() {
    return _CategoryImageState();
  }
}

class _CategoryImageState extends State<CategoryImage> {
  File? selectedImage;
  var isLoadImage = true;

  void pickCategoryImage() async {
    final pickedCategoryImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
    widget.onSelectedCategoryImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (selectedImage != null) {
      content = Image.file(
        selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (widget.initialImageUrl != null) {
      // Nếu không có ảnh đã chọn nhưng có ảnh ban đầu, hiển thị ảnh ban đầu
      content = InkWell(
        onTap: pickCategoryImage,
        child: CachedNetworkImage(
          imageUrl: widget.initialImageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else {
      // Nếu không có ảnh nào, hiển thị nút cho phép chọn ảnh
      content = TextButton.icon(
        onPressed: pickCategoryImage,
        icon: const Icon(Icons.camera),
        label: const Text('Chọn ảnh'),
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
