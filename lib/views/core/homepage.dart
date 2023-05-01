import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/const/app_constant_imports.dart';
import 'package:summarize_app/const/user_header.dart';
import 'package:summarize_app/services/analytics_service.dart';
import 'package:summarize_app/services/toast_service.dart';
import 'package:summarize_app/view_model/network_provider/questions_provider.dart';
import 'package:summarize_app/view_model/network_provider/summary_provider.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';
import 'package:summarize_app/views/core/mainpage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    TextEditingController myfeature = TextEditingController();
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
              UserHeader(
                message: "Welcome $userName",
              ),
              const SizedBox(
                height: 120,
              ),
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
                ],
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
              // Container(
              //   constraints: const BoxConstraints(
              //       maxHeight: 300, maxWidth: double.infinity),
              //   margin: const EdgeInsets.all(15),
              //   padding: const EdgeInsets.all(15),
              //   child: SingleChildScrollView(
              //     child: Card(
              //       child: Text(pdfProvider.myText),
              //     ),
              //   ),
              // ),
              Visibility(
                visible: pdfProvider.pdfDoc != null,
                child: Container(
                  padding: const EdgeInsets.all(AppDimension.medium),
                  child: Column(
                    children: [
                      // Consumer<SummaryProvider>(
                      //   builder: (context, networkData, child) {
                      //     return AppElevatedButton(
                      //       onPressed: () async {
                      //         if (pdfProvider.pdfDoc == null) {
                      //           showToast("Please Upload a PDF");
                      //         } else {
                      //           showToast("Coming soon");
                      //           // await networkData
                      //           //     .getSummary(userInput: pdfProvider.myText)
                      //           //     .then(
                      //           //       (value) => Navigator.push(
                      //           //         context,
                      //           //         MaterialPageRoute(
                      //           //           builder: (context) => const MainPage(),
                      //           //         ),
                      //           //       ),
                      //           //     );
                      //         }
                      //       },
                      //       borderColor: AppColor.kPrimaryColor,
                      //       isLoading: false,
                      //       label: 'Summarize Whole Doc',
                      //     );
                      //   },
                      // ),
                      //const Spacing.meduimHeight(),
                      AppElevatedButton(
                        onPressed: () {
                          if (pdfProvider.pdfDoc == null) {
                            showToast("Please Upload a PDF");
                          } else {
                            openDialog(context, false);
                          }
                        },
                        borderColor: AppColor.kPrimaryColor,
                        isLoading: false,
                        label: 'Summarize Page',
                      ),
                      const Spacing.meduimHeight(),
                      AppElevatedButton(
                        onPressed: () {
                          if (pdfProvider.pdfDoc == null) {
                            showToast("Please Upload a PDF");
                          } else {
                            openDialog(context, true);
                          }
                        },
                        borderColor: AppColor.kPrimaryColor,
                        isLoading: false,
                        label: 'Generate Questions',
                      ),
                      const Spacing.meduimHeight(),
                      AppElevatedButton(
                        onPressed: () {
                          showToast("What would you like the app to do?");
                          if (!context.mounted) return;
                          showImprovement(
                            context,
                            myfeature,
                          );
                        },
                        borderColor: AppColor.kPrimaryColor,
                        isLoading: false,
                        label: 'Suggest Improvement',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  openDialog(BuildContext context, bool isQuestion) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose Details'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropDown(
                  isQuestion: isQuestion,
                ),
              ],
            ),
            elevation: 0,
            alignment: Alignment.center,
            contentPadding: const EdgeInsets.all(15),
            // actionsPadding: EdgeInsets.all(15),
            // actions: const [],
          );
        },
      );

  showImprovement(BuildContext context, TextEditingController myFeature) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return Padding(
            padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(AppDimension.big),
              margin: const EdgeInsets.all(AppDimension.big),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    hintText: "Describe your feature or suggestion",
                    labelText: "What feature would you like us to add",
                    controller: myFeature,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _launchURLApp(myFeature.text.trim());

                      Navigator.pop(context);
                    },
                    child: const Text("Suggest Feature"),
                  ),
                ],
              ),
            ),
          );
        },
      );
  _launchURLApp(String featureMessage) async {
    var contact = "+254115017058";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hello I'm Using The StudyPalApp And I would love the following feature $featureMessage";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      showToast("error");
    }
  }
}

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
                    AnalyticsService.logSummaryEvent(true);
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
