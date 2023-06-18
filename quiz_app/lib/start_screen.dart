import 'package:flutter/material.dart';
import 'package:quiz_app/styled_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen( {super.key,required this.startQuiz});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(149, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          const StyledText(
            'Learn Flutter the fun way!',
            Color.fromARGB(255, 255, 255, 255),
            24,
            FontWeight.normal,
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text(
              'Start Quiz',
              // Color.fromARGB(250, 255, 255, 255),
              // 16,
            ),
          ),
        ],
      ),
    );
  }
}
