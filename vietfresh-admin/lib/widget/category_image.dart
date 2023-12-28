import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryImage extends StatefulWidget {
  const CategoryImage({super.key, required this.onSelectedCategoryImage});

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
    final pickedCategoryImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery);
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
