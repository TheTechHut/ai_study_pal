import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/services/toast/toast_service.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';
import 'package:summarize_app/shared/functions/app_dialog.dart';
import 'package:summarize_app/shared/functions/suggest_improvement_service.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';

class ActionButtons extends StatelessWidget {
  final TextEditingController myFeature;
  const ActionButtons({super.key, required this.myFeature});

  @override
  Widget build(BuildContext context) {
    return Consumer<PdfProvider>(builder: (context, pdfProvider, _) {
      return Visibility(
        visible: pdfProvider.pdfDoc != null,
        child: Container(
          padding: const EdgeInsets.all(AppDimension.medium),
          child: Column(
            children: [
              AppElevatedButton(
                onPressed: () {
                  if (pdfProvider.pdfDoc == null) {
                    showToast("Please Upload a PDF");
                  } else {
                    AppDialog.openDialog(context, false);
                  }
                },
                borderColor: AppColor.kPrimaryColor,
                isLoading: false,
                label: 'Summarize Page',
              ),
              const Spacing.meduimHeight(),
              AppElevatedButton(
                onPressed: () {
                  if (pdfProvider.pdfDoc == null) {
                    showToast("Please Upload a PDF");
                  } else {
                    AppDialog.openDialog(context, true);
                  }
                },
                borderColor: AppColor.kPrimaryColor,
                isLoading: false,
                label: 'Generate Questions',
              ),
              const Spacing.meduimHeight(),
              AppElevatedButton(
                onPressed: () {
                  showToast("What would you like the app to do?");
                  if (!context.mounted) return;
                  SuggestImprovement.suggestImprovement(
                    context,
                    myFeature,
                  );
                },
                borderColor: AppColor.kPrimaryColor,
                isLoading: false,
                label: 'Suggest Improvement',
              ),
            ],
          ),
        ),
      );
    });
  }
}
