import 'package:flutter/material.dart';

class StyleButton extends StatelessWidget {
  const StyleButton(
    this.ans,
    this.onpress, {
    super.key,
  });

  final String ans;
  final void Function() onpress;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10, //Khoảng cách dọc
            horizontal: 40, //Khoảng cách ngang
          ),
          backgroundColor: const Color.fromARGB(255, 37, 2, 98),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Text(
          ans,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
