import 'package:flutter/material.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';

class ImageRecognition extends StatelessWidget {
  const ImageRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visibility(
            replacement: Column(
              children: [
                const Text(
                  "Pick a new PDF document and wait for it to load...",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () async {},
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
                      onPressed: () async {},
                    ),
                    Text(
                      'Upload your PDF',
                      style: AppTextStyle.body4,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 18),
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
    );
  }
}
