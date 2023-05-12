import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/styles/app_text_style.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';

class DocumentView extends StatelessWidget {
  const DocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PdfProvider>(builder: (context, pdfProvider, child) {
      return Visibility(
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
      );
    });
  }
}
