import 'package:flutter/material.dart';

import 'package:first_app/gradient_container.dart';

//main() --> tên chức năng, void --> kiểu trả về
void main() {
  // --> thân hàm, xác định các hàm
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(198, 255, 221, 1),
          Color.fromARGB(251, 215, 134, 1),
          Color.fromARGB(247, 121, 125, 1),
        ),
      ),
    ),
  );
}
