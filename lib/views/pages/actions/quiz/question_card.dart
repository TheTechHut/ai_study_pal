import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';
import 'package:summarize_app/shared/functions/function_imports.dart';
import 'package:summarize_app/view_model/network_provider/questions_provider.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.large),
      child: Column(children: [
        Text(
          "Questions 1:",
          style: AppTextStyle.heading2,
        ),
        Consumer<QuestionsProvider>(
          builder: (context, value, child) {
            if (value.result.choices != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    value.result.choices!.first.text
                        .toString()
                        .split('2')
                        .first,
                    style: AppTextStyle.summaryText,
                  ),
                ),
              );
            } else if (value.hasError) {
              return Row(
                children: [
                  const Icon(Icons.error),
                  AppErrorDialog.showErrorDialog(value.errorMessage, context),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ]),
    );
  }
}
