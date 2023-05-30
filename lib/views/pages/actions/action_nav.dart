import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/styles/app_text_style.dart';
import 'package:summarize_app/shared/widgets/spacing.dart';
import 'package:summarize_app/shared/widgets/user_header.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/pages/actions/quiz/questions_view.dart';
import 'package:summarize_app/views/pages/actions/summarize/summary_view.dart';

class ActionMainPage extends StatelessWidget {
  final bool isQuestion;
  const ActionMainPage({
    super.key,
    required this.isQuestion,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FirebaseAuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacing.height(48),
              UserHeader(
                message: "Hey ${authProvider.username}",
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                isQuestion ? "Your questions" : "Your Summary",
                style: AppTextStyle.heading3,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                child: isQuestion ? const QuestionView() : const SummaryView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
