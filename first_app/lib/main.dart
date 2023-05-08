import 'package:flutter/material.dart';

import 'package:first_app/gradient_container.dart';

//main() --> tên chức năng, void --> kiểu trả về
void main() {
  // --> thân hàm, xác định các hàm
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 155, 132, 217),
          Color.fromARGB(1, 198, 144, 144),
        ),
      ),
    ),
  );
}
