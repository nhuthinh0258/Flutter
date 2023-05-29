import 'package:flutter/material.dart';
import 'package:quiz_app/data/question.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/result_screen.dart';

class Quizz extends StatefulWidget {
  const Quizz({super.key});

  @override
  State<Quizz> createState() {
    return _Quizz();
  }
}

class _Quizz extends State<Quizz> {
  // C1:
  // Widget? activeScreen ; // May be null

  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  List<String> selectedAnswer = [];

  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen'; // Nhấn nút start để bắt đầu vào màn hình câu hỏi
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == question.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
    //So sánh đã chọn hết câu hỏi hay chưa, nếu đủ thì thêm kết quả vào màn hình result
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];
      activeScreen = 'question-screen';     //Restart lại câu hỏi
    });
  }

  @override
  Widget build(context) {
    // C2:
    // final screenWidget = activeScreen == 'start-screen'
    // ? StartScreen(switchScreen)
    // : const QuestionScreen();

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
          chooseAnswer); //Chuyển sang question_screen sau khi nhấn start
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        selectedAnswer,
        restartQuiz,
      ); //Điều hướng sang result_screen
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
