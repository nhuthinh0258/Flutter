import 'package:favorite_place/model/locationplace.dart';
import 'package:favorite_place/widget/image_input.dart';
import 'package:favorite_place/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class NewPlaceItem extends StatelessWidget {
  const NewPlaceItem(
      {super.key, required this.buttonAddPlace, required this.controller,required this.formKey,required this.onSelectedImage,required this.onSelectedLocation});

  final void Function() buttonAddPlace;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final void Function(File image) onSelectedImage;
  final void Function(LocationPlace location) onSelectedLocation;

  String? validatorNameProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Tên sản phẩm rỗng';
    }
    //Kiểm tra tên sản phẩm sau khi loại bỏ khoảng trắng có chứa ít nhất 3 kí tự
    else if (value.trim().length < 3) {
      return 'Tên sản phẩm phải có ít nhất 3 ký tự';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              ImageInput(onSelectedImage: onSelectedImage,),
              const SizedBox(height: 20,),
              LocationInput(onSelectedLocation: onSelectedLocation,),
              const SizedBox(height: 20,),
              TextFormField(
                style: GoogleFonts.ubuntuCondensed(
                  fontWeight:
                      Theme.of(context).textTheme.titleMedium!.fontWeight,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  //style lại thông báo lỗi của validator
                  errorStyle: TextStyle(color: Colors.red),
                  //Thêm viền xung quanh
                  border: OutlineInputBorder(),
                  label: Text(
                    'Tên địa điểm',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                validator: validatorNameProduct,
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: buttonAddPlace,
                icon: const Icon(Icons.add),
                label: Text(
                  'Thêm địa điểm',
                  style: GoogleFonts.ubuntuCondensed(
                    fontWeight:
                        Theme.of(context).textTheme.titleSmall!.fontWeight,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(
                          255, 78, 93, 105)), // Màu nền của nút
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
