import 'package:flutter/material.dart';
import 'package:summarize_app/views/pages/actions/quiz/answer_section.dart';
import 'package:summarize_app/views/pages/actions/quiz/question_card.dart';

//TODO define a carousel view for questions

class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> questions = List.generate(
      5,
      growable: false,
      (index) => const Column(
        children: [
          QuizCard(),
          AnswerInput(),
        ],
      ),
    );
    return PageView(children: questions);
  }
}
