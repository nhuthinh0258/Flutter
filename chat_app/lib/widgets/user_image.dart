import 'dart:io';
import 'package:chat_app/screen/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebaseStorage = FirebaseStorage.instance;

class UserImage extends StatefulWidget {
  const UserImage({super.key});

  @override
  State<UserImage> createState() {
    return _UserImage();
  }
}

class _UserImage extends State<UserImage> {
  File? pickerImage;
  bool isLoadingImage = false;

  //Hàm tải ảnh lên firestorage
  void imageUpload(File image) async {
    setState(() {
      isLoadingImage = true;
    });
    //Lấy thông tin người dùng hiện tại từ Firebase Authentication
    final user = firebase.currentUser!;

    //Tạo một tham chiếu đến Firebase Storage
    final storageRef =
        firebaseStorage.ref().child('user_image').child('${user.uid}.jpg');
    // Tải file ảnh lên Firebase Storage
    await storageRef.putFile(image);
    //Lấy URL của ảnh sau khi tải lên
    final imageUrl = await storageRef.getDownloadURL();
    await firestore.collection('users').doc(user.uid).update({
      'image': imageUrl,
    });
    setState(() {
      isLoadingImage = false;
    });
  }

  //Hàm chọn ảnh
  void onPickImage() async {
    final pickImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (pickImage == null) {
      return;
    }

    setState(() {
      pickerImage = File(pickImage.path);
    });

    imageUpload(pickerImage!);
  }

  @override
  Widget build(BuildContext context) {
    final user = firebase.currentUser!;
    return StreamBuilder(
      stream: firestore.collection('users').doc(user.uid).snapshots(),
      builder: ((ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting || isLoadingImage) {
          return const CircularProgressIndicator();
        }
        if (!userSnapshot.hasData || userSnapshot.data!.data() == null) {
          return const Text('Không có dữ liệu');
        }
        final userData = userSnapshot.data!.data();
        final imageUser = userData?['image']; // Sử dụng toán tử an toàn

        return CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          
          backgroundImage: imageUser != null ? NetworkImage(imageUser) : null,
          child: GestureDetector(
            onTap: onPickImage,
            child: imageUser == null ? const Icon(Icons.camera, size: 25) : null,
          ),
        );
      }),
    );
  }
}
