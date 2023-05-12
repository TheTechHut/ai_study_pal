import 'package:flutter/material.dart';
import 'package:summarize_app/views/pages/home/drop_down.dart';

class AppDialog {
  static openDialog(BuildContext context, bool isQuestion) => showDialog(
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
}
