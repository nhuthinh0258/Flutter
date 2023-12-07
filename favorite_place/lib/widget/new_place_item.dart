import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPlaceItem extends StatelessWidget {
  const NewPlaceItem(
      {super.key,
      required this.buttonAddPlace,required this.controller});


  final void Function() buttonAddPlace;
  final TextEditingController controller;

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                style: GoogleFonts.ubuntuCondensed(
                  fontWeight: Theme.of(context).textTheme.titleMedium!.fontWeight,
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
                      const Color.fromARGB(255, 78, 93, 105)), // Màu nền của nút
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
