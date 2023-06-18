import 'package:flutter/material.dart';
import 'package:quiz_app/styled_text.dart';

class QuestionIdentifi extends StatelessWidget {
  const QuestionIdentifi( {super.key,required this.isCorectAnswer,required this.questionIndex});

  final int questionIndex;
  final bool isCorectAnswer;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isCorectAnswer
                ? const Color.fromARGB(255, 104, 119, 231)
                : const Color.fromARGB(255, 221, 120, 215),
            borderRadius: BorderRadius.circular(100),),
        child: StyledText(
          questionNumber.toString(),
          Colors.black,
          14,
          FontWeight.bold,
        ),
      ),
    );
  }
}
