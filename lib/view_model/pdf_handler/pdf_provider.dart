import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf_text/pdf_text.dart';

class PdfProvider extends ChangeNotifier {
  PDFDoc? pdfDoc;
  String myText = "";

  Future pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      notifyListeners();
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
