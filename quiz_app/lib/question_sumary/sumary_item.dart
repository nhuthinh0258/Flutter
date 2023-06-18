import 'package:flutter/material.dart';
import 'package:quiz_app/question_sumary/question_identifi.dart';
import 'package:quiz_app/styled_text.dart';

class SumaryItem extends StatelessWidget {
  const SumaryItem(this.item, {super.key});

  final Map<String, Object> item;

  @override
  Widget build(BuildContext context) {
    final isCorect = item['corect_answer'] == item['your_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifi(
            questionIndex: item['question_index'] as int,
            isCorectAnswer: isCorect,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['question'] as String,
                  style: const TextStyle(
                    color:Colors.white,
                    fontSize:18,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                StyledText(
                  item['your_answer'] as String,
                  const Color.fromARGB(255, 202, 171, 252),
                  16,
                  FontWeight.normal,
                ),
                StyledText(
                  item['corect_answer'] as String,
                  const Color.fromARGB(255, 181, 254, 246),
                  16,
                  FontWeight.normal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
