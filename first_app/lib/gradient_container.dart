import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget{
  const GradientContainer({super.key});

  @override
  Widget build(context){
    return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 234, 31, 207),
                Color.fromARGB(255, 91, 71, 71)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Text(
              'Xin chào',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 28,
              ),
            ),
          ),
        );
  }
}