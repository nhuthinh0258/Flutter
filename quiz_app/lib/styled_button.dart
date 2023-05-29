import 'package:flutter/material.dart';

class StyleButton extends StatelessWidget {
  const StyleButton(this.ans,this.onpress,{super.key,});

  final String ans;
  final void Function() onpress;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
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
    );
  }
}
