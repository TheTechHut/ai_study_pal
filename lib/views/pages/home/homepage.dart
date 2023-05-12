import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/widgets/user_header.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';
import 'package:summarize_app/views/pages/home/action_buttons.dart';
import 'package:summarize_app/views/pages/home/document_view.dart';
import 'package:summarize_app/views/pages/home/upload_pdf_view.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    TextEditingController myFeature = TextEditingController();
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
              const DocumentView(),
              ActionButtons(myFeature: myFeature),
              const UploadView(),
            ],
          ),
        ),
      ),
    );
  }
}
