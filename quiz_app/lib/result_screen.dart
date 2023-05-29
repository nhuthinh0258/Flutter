import 'package:flutter/material.dart';
import 'package:quiz_app/data/question.dart';
import 'package:quiz_app/question_sumary/question_sumary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.choosenAnswer, this.restart, {super.key});

  final void Function() restart;
  final List<String> choosenAnswer;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': question[i].text,
        'corect_answer': question[i].answer[0],
        'your_answer': choosenAnswer[i]
      });
    }

    return summary;
  }

  @override
  Widget build(context) {
    final sumaryData = getSummaryData();
    final numTotalQuestions = question.length;
    final numCorrectQuestions = sumaryData.where((item) {
      return item['your_answer'] == item['corect_answer'];
    }).length;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "You answered correctly $numCorrectQuestions out of $numTotalQuestions question corectly!",
              style: const TextStyle(
                color: Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSumary(sumaryData),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
              onPressed: restart,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.replay_outlined),
              label: const Text(
                'Restart Quiz!',
                // Color.fromARGB(250, 255, 255, 255),
                // 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
