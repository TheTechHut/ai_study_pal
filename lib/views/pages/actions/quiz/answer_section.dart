import 'package:flutter/material.dart';
import 'package:summarize_app/shared/widgets/app_text_field.dart';

class AnswerInput extends StatelessWidget {
  const AnswerInput({super.key});
  //TODO: Add a green on successful answer and red on error. Add animation is correct or wrong
  @override
  Widget build(BuildContext context) {
    TextEditingController userAnswer = TextEditingController();
    return AppTextField(
      hintText: "Answer here",
      labelText: "Your Answer",
      controller: userAnswer,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send),
        onPressed: () {},
      ),
    );
  }
}
