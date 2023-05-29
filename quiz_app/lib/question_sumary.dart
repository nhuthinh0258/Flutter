import 'package:flutter/material.dart';
import 'package:quiz_app/sumary_item.dart';

class QuestionSumary extends StatelessWidget {
  const QuestionSumary(this.questionsumary, {super.key});

  final List<Map<String, Object>> questionsumary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: questionsumary.map(
            (item) {
              return SumaryItem(item);
            },
          ).toList(),
        ),
      ),
    );
  }
}
