import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';
import 'package:summarize_app/shared/functions/dialog.dart';
import 'package:summarize_app/shared/functions/suggest_improvement_service.dart';
import 'package:summarize_app/shared/widgets/user_header.dart';
import 'package:summarize_app/services/toast/toast_service.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    TextEditingController myfeature = TextEditingController();
    final pdfProvider = Provider.of<PdfProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              Visibility(
                visible: pdfProvider.pdfDoc == null,
                child: Column(
                  children: [
                    UserHeader(
                      message: "Welcome $userName",
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: pdfProvider.pdfDoc != null,
                child: Column(children: [
                  Text(
                    "Your document",
                    style: AppTextStyle.heading3,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      minHeight: MediaQuery.of(context).size.width * 0.4,
                    ),
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Text(
                            pdfProvider.myText,
                            style: AppTextStyle.body6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Visibility(
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
                            myfeature,
                          );
                        },
                        borderColor: AppColor.kPrimaryColor,
                        isLoading: false,
                        label: 'Suggest Improvement',
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: pdfProvider.pdfDoc == null,
                replacement: Column(
                  children: [
                    Text(
                      pdfProvider.pdfDoc == null
                          ? "Pick a new PDF document and wait for it to load..."
                          : "PDF document loaded, ${pdfProvider.pdfDoc!.length} pages\n",
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload),
                      onPressed: () async {
                        await pdfProvider.pickPDFText();
                        await pdfProvider.readWholeDoc();
                      },
                    ),
                    Text(
                      'Upload a different',
                      style: AppTextStyle.body4,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.upload),
                          onPressed: () async {
                            await pdfProvider.pickPDFText();
                            await pdfProvider.readWholeDoc();
                          },
                        ),
                        Text(
                          'Upload your PDF',
                          style: AppTextStyle.body4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            pdfProvider.pdfDoc == null
                                ? "Pick a new PDF document and wait for it to load..."
                                : "PDF document loaded, ${pdfProvider.pdfDoc!.length} pages\n",
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
