import 'package:flutter/material.dart';
import 'package:summarize_app/views/pages/home/document_view.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            DocumentView(),
          ],
        ),
      ),
    );
  }
}
