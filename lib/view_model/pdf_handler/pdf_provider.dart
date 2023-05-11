import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf_text/pdf_text.dart';

class PdfProvider extends ChangeNotifier {
  PDFDoc? pdfDoc;
  String myText = "";
  FilePickerResult? result;

  Future pickPDFText() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'doc'],
      );
      if (result != null) {
        pdfDoc = await PDFDoc.fromPath(result!.files.single.path!);
      }
    } catch (e) {
      log("$e");
    }

    if (result != null) {
      try {
        Uint8List uploadfile = result!.files.single.bytes!;
        pdfDoc = await PDFDoc.fromPath(result!.files.single.path!);
        log(uploadfile.length.toString());
        notifyListeners();
      } catch (e) {
        log("$e");
      }
    }
  }

  Future<String> readRandomPage({required int pageNumber}) async {
    if (pdfDoc == null) {
      return "No PDF";
    }

    String text = await pdfDoc!.pageAt(pageNumber).text;

    myText = text;
    notifyListeners();
    return myText;
  }

  Future<String> readWholeDoc() async {
    if (pdfDoc == null) {
      return "No PDF";
    }
    String text = await pdfDoc!.text;
    myText = text;
    notifyListeners();
    return myText;
  }
}
