import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/services/analytics/analytics_service.dart';
import 'package:summarize_app/view_model/network_provider/questions_provider.dart';
import 'package:summarize_app/view_model/network_provider/summary_provider.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';
import 'package:summarize_app/views/pages/actions/mainpage.dart';

class DropDown extends StatefulWidget {
  final bool isQuestion;
  const DropDown({super.key, required this.isQuestion});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int dropDownValue = 1;
  @override
  Widget build(BuildContext context) {
    bool isQuestion = widget.isQuestion;
    final pdfProvider = Provider.of<PdfProvider>(context);
    List<DropdownMenuItem<int>> items = List.generate(
      pdfProvider.pdfDoc!.length + 1,
      growable: false,
      (index) => DropdownMenuItem(
        value: index,
        child: Text(
          index.toString(),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Pick page'),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            items: items,
            onChanged: (int? value) async {
              setState(() {
                dropDownValue = value!;
              });
            },
            value: dropDownValue,
          ),
        ),
        isQuestion
            ? Consumer<QuestionsProvider>(
                builder: (context, networkProvider, child) => ElevatedButton(
                  onPressed: () async {
                    await pdfProvider
                        .readRandomPage(pageNumber: dropDownValue)
                        .then(
                          (value) async => await networkProvider.getQuestion(
                            userInput: pdfProvider.myText,
                          ),
                        )
                        .whenComplete(
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(
                                isQuestion: true,
                              ),
                              settings:
                                  const RouteSettings(name: "main_page_nav"),
                            ),
                          ),
                        );
                    AnalyticsService.logGenQuestionEvent(true);
                  },
                  child: const Text('Generate Question'),
                ),
              )
            : Consumer<SummaryProvider>(
                builder: (context, networkProvider, child) => ElevatedButton(
                  onPressed: () async {
                    await pdfProvider
                        .readRandomPage(pageNumber: dropDownValue)
                        .then(
                          (value) async => await networkProvider.getSummary(
                            userInput: pdfProvider.myText,
                          ),
                        )
                        .whenComplete(
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(
                                isQuestion: false,
                              ),
                              settings:
                                  const RouteSettings(name: "main_page_nav"),
                            ),
                          ),
                        );
                    AnalyticsService.logSummaryEvent(true);
                  },
                  child: const Text('Summarize'),
                ),
              )
        //DropdownButton(items: , onChanged: (int items){pdfProvider.pdfDoc.pageAt(items)}),
      ],
    );
  }
}
