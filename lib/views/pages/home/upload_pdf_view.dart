import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PdfProvider>(builder: (context, pdfProvider, _) {
      return Visibility(
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
      );
    });
  }
}
