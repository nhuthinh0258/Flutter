import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onSelectedImage});

  final void Function(File image) onSelectedImage;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  //Hàm chụp ảnh
  void takePicture() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 200);

    //Kiểm tra người dùng có chụp ảnh hay không, nếu hủy chụp ảnh thì pickedImage sẽ là null
    if (pickedImage == null) {
      return; //Kết thúc ngay lập tức, không thực hiện các đoạn code phía sau
    }
    //Cập nhật lại UI sau khi chụp ảnh
    setState(() {
      selectedImage = File(pickedImage.path);
    });
    widget.onSelectedImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Chụp/chọn ảnh'),
    );

    //Nếu selectedImage ko phải null, tạo widget để hiển thị ảnh đấy
    if (selectedImage != null) {
      content = GestureDetector(
        onTap: takePicture,
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
