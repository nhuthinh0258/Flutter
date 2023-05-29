

class QuizQuestion{

  const QuizQuestion(this.text,this.answer);

  final String text;
  final List<String> answer;

  List<String> getshufflerAnswer(){
    final shufflerAnswer = List.of(answer);
    shufflerAnswer.shuffle();
    return shufflerAnswer;
  }
}