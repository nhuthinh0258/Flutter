import 'package:favorite_place/model/locationplace.dart';
import 'package:favorite_place/providers/user_place.dart';
import 'package:favorite_place/widget/new_place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() {
    return _NewPlaceScreenState();
  }
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  LocationPlace? selectedLocation;

  void onSelectedImage(File image){
    selectedImage = image;
  }

  void onSelectedLocation(LocationPlace location){
    selectedLocation = location;
  }
  //Giải phóng tài nguyên, bộ nhớ khi không dùng nữa
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //Xử lý button addplace
  void buttonAddPlace() {
    final enteredPlaceName = controller.text;
    if (formKey.currentState!.validate() && selectedImage != null && selectedLocation != null)  {
      //lấy danh sách địa điểm hiện tại từ provider để xử lý một hành động nhưng không cần widget cập nhật UI ==> sẽ sử dụng read.
      ref.read(userPlaceProvider.notifier).addPlace(enteredPlaceName,selectedImage!,selectedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm địa điểm'),
      ),
      body: NewPlaceItem(
        onSelectedLocation: onSelectedLocation,
        onSelectedImage:onSelectedImage,
        buttonAddPlace: buttonAddPlace,
        controller: controller,
        formKey: formKey,
      ),
    );
  }
}
