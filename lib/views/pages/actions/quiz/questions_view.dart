import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/functions/function_imports.dart';
import 'package:summarize_app/shared/styles/app_text_style.dart';
import 'package:summarize_app/view_model/network_provider/questions_provider.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsProvider>(
      builder: (context, value, child) {
        if (value.result.choices != null) {
          return SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  value.result.choices!.first.text.toString(),
                  style: AppTextStyle.summaryText,
                ),
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
    );
  }
}
