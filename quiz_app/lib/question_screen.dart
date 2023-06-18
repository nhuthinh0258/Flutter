import 'package:flutter/material.dart';
import 'package:quiz_app/data/question.dart';
import 'package:quiz_app/styled_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen( {super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreen();
  }
}

class _QuestionScreen extends State<QuestionScreen> {
  var currentQuestion = 0;
  void answerQuestion(String selectAnswer) {
    widget.onSelectAnswer(selectAnswer);
    // C1: currentQuestion = currentQuestion +1;
    setState(() {
      currentQuestion++; //Tự động chuyển màn sau khi chọn đáp án
    });
  }

  @override
  Widget build(context) {
    // final curentQuestion = question[currentQuestion];
    // return Center(
    //   child: Container(
    //     margin: const EdgeInsets.all(40),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //           Text(
    //           curentQuestion.text,
    //           style: const TextStyle(
    //             color: Color.fromARGB(255, 230, 200, 253),
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //         const SizedBox(
    //           height: 30,
    //         ),
    //         ...curentQuestion.getshufflerAnswer().map((item) {
    //           return StyleButton(
    //             item,
    //             (){
    //               answerQuestion(item);
    //             },
    //           );
    //         })
    //       ],
    //     ),
    //   ),
    // );
    final curentQuestion = question[currentQuestion];

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              curentQuestion.text,
              style: const TextStyle(
                color: Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            GridView.count(
              crossAxisCount: 2, // Số cột trong lưới
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: curentQuestion.getshufflerAnswer().map((item) {
                return StyleButton(
                  item,
                  () {
                    answerQuestion(item);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
