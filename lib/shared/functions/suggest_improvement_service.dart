import 'package:flutter/material.dart';
import 'package:summarize_app/shared/components/app_dimension.dart';
import 'package:summarize_app/shared/functions/launch_whatsapp.dart';
import 'package:summarize_app/shared/widgets/app_text_field.dart';

class SuggestImprovement {
  static suggestImprovement(
          BuildContext context, TextEditingController myFeature) =>
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
                      LaunchWhatsApp.launchWhatsApp(
                        featureMessage: myFeature.text,
                      );
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
}
