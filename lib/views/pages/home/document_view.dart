import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/styles/app_text_style.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';

class DocumentView extends StatelessWidget {
  const DocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PdfProvider>(
      builder: (context, pdfProvider, child) {
        return Visibility(
          visible: pdfProvider.pdfDoc != null,
          child: Column(
            children: [
              Text(
                "Your document",
                style: AppTextStyle.heading3,
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: Card(
                      child: SingleChildScrollView(
                        child: Text(
                          pdfProvider.myText,
                          style: AppTextStyle.body6,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 10,
                    right: 10,
                    child: Icon(
                      Icons.fullscreen,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  fullScreenView(bool isSelected) {
    if (isSelected) {
      //TODO enlarge screen
    } else {
      //TODO decrease size ==> Toggle button location
    }
  }
}
