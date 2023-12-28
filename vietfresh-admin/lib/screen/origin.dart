import 'package:admin/screen/auth_admin.dart';
import 'package:admin/screen/new_category.dart';
import 'package:admin/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../provider/bottom_navigation_provider.dart';

class Origin extends ConsumerStatefulWidget {
  const Origin({super.key});

  @override
  ConsumerState<Origin> createState() {
    return _OriginState();
  }
}

class _OriginState extends ConsumerState<Origin> {
  var originController = TextEditingController();
  late FocusNode myFocusNode;
  File? pickerImage;
  bool isLoadingImage = false;
  // var isSending = false;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    // Thêm listener
    myFocusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    if (myFocusNode.hasFocus) {
      ref.read(bottomNavigationProvider.notifier).hide();
    } else {
      ref.read(bottomNavigationProvider.notifier).show();
    }
  }

  //giải phóng tài nguyên
  @override
  void dispose() {
    originController.dispose();
    super.dispose();
  }

  //Hàm xử lý gửi tin nhắn
  void submitMessage() async {
    //enteredMessage lấy nội dung hiện tại từ TextField thông qua messageController.text
    final enteredMessage = originController.text;
    //kiểm tra xem nội dung nhập sau khi loại bỏ khoảng trắng ở đầu và cuối có phải là rỗng không
    if (enteredMessage.trim().isEmpty) {
      //Nếu rỗng, kết thúc không làm gì cả
      return;
    }

    //Lấy dữ liệu người dùng
    final user = firebase.currentUser!;

    final originId = 'origin-${DateTime.now().millisecondsSinceEpoch}';
    //Gửi đến firebase
    firestore.collection('orgin').doc(originId).set({
      'userid': user.uid,
      'name': enteredMessage,
      'created_at': Timestamp.now(),
    });

    //xóa nội dung của TextField sau khi gửi, chuẩn bị cho việc nhập tin nhắn tiếp theo.
    originController.clear();
  }

  //Hàm tải ảnh lên firestorage
  void imageUpload() async {
    setState(() {
      isLoadingImage = true;
    });

    final bannerId = 'banner-${DateTime.now().millisecondsSinceEpoch}';
    //Tạo một tham chiếu đến Firebase Storage
    final storageRef =
        firebaseStorage.ref().child('banner_image').child('$bannerId.jpg');
    // Tải file ảnh lên Firebase Storage
    await storageRef.putFile(pickerImage!);
    //Lấy URL của ảnh sau khi tải lên
    final imageUrl = await storageRef.getDownloadURL();
    await firestore.collection('banner').doc(bannerId).set({
      'image': imageUrl,
      'create_at': Timestamp.now(),
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Thêm ảnh thành công'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Đồng ý',
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
            }),
      ),
    );

    setState(() {
      pickerImage = null;
      isLoadingImage = false;
    });
  }

  //Hàm chọn ảnh
  void onPickImage() async {
    final pickImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickImage == null) {
      return;
    }

    setState(() {
      pickerImage = File(pickImage.path);
    });

  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: onPickImage,
      icon: const Icon(Icons.camera),
      label: const Text('Chọn ảnh'),
    );

    //Nếu selectedImage ko phải null, tạo widget để hiển thị ảnh đấy
    if (pickerImage != null) {
      content = isLoadingImage
          ? const CircularProgressIndicator()
          : GestureDetector(
              onTap: onPickImage,
              child: Image.file(
                pickerImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm xuất xứ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: originController,
                focusNode: myFocusNode,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                //Mỗi câu mới sẽ bắt đầu bằng chữ viết hoa
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('xuất xứ'),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: submitMessage,
                    style: ButtonStyle(
                      //Thay đổi màu nền của button theo màu theme đã khai báo
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorLight,
                      ),
                    ),
                    child: const Style(
                      outputText: 'Thêm xuất xứ',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                ),
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                child: content,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: imageUpload,
                    style: ButtonStyle(
                      //Thay đổi màu nền của button theo màu theme đã khai báo
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorLight,
                      ),
                    ),
                    child: const Style(
                      outputText: 'Thêm banner',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
