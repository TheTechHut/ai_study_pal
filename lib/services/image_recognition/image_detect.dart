import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';

class ImageDetector {
  final textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );
  final InputImage inputImage =
      InputImage.fromFilePath(PdfProvider().result!.files.single.path!);
  recognizeText() async {
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    debugPrint(text);
    for (TextBlock block in recognizedText.blocks) {
      // final Rect rect = block.boundingBox;
      // final List<Point<int>> cornerPoints = block.cornerPoints;
      // final String text = block.text;
      // final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          debugPrint(element.text);
        }
      }
    }
  }
}
