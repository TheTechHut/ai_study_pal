import 'dart:developer';
import 'package:ai_study_pal/const/api_url.dart';
import 'package:ai_study_pal/model/summary_model.dart';
import 'package:ai_study_pal/services/network_helper.dart';
import 'package:ai_study_pal/services/network_service.dart';
import 'package:ai_study_pal/services/toast_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SummaryProvider extends ChangeNotifier {
  SummaryModel result = SummaryModel();
  bool hasError = false;
  String errorMessage = "";
  Future<SummaryModel?> getSummary({required String userInput}) async {
    final response = await NetworkService(
      body: {
        "model": AppUrl.model,
        "messages": [
          {
            "role": "system",
            "content":
                "You are AI Study pal, a helpful study buddy who helps students learn quickly by generating helpful summaries without degrading the meaning of the message"
          },
          {
            "role": "user",
            "content": "What are the key takeaway from this article: $userInput"
          }
        ],
        "temperature": 0.7,
        "max_tokens": 64,
        "top_p": 1.0,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0
      },
      headers: AppUrl.gptHeaders,
    ).sendRequest(
      requestType: RequestType.post,
      uri: AppUrl.baseUrlGPT,
    );
    if (response == null) {
      hasError = true;
      result = SummaryModel(
        choices: [
          Choice(
            text: "No response",
          )
        ],
      );
    } else if (response.body.isEmpty) {
      hasError = true;
      result = SummaryModel(
        choices: [
          Choice(
            text: "Server error",
          )
        ],
      );
    } else if (response.statusCode != 200) {
      showToast("Oops something went wrong");
      hasError = true;
      notifyListeners();
      result = SummaryModel(
        choices: [
          Choice(
            text: "Oops something went wrong",
          )
        ],
      );
    }
    log(response!.statusCode.toString());
    result = summaryModelFromJson(response.body);
    if (response.statusCode == 200) {
      if (result.choices!.first.text!.contains("â¢")) {
        result = SummaryModel(
          choices: [
            Choice(
              text:
                  result.choices!.first.text!.replaceAll(RegExp(r'â¢'), "=>"),
            ),
          ],
        );
      }
    }
    log(response.body.toString());
    errorMessage = response.statusCode.toString();
    notifyListeners();

    return await NetworkHelper.filterResponse(
      callBack: (json) {
        result;
        log(result.choices!.first.text.toString());
      },
      response: response,
      onFailureCallBackWithMessage: (errorType, msg) {
        log('Error Type - $errorType - Message: $msg');
      },
    );
  }
}
