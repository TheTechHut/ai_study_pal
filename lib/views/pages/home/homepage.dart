import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/widgets/user_header.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/pages/home/action_buttons.dart';
import 'package:summarize_app/views/pages/home/document_view.dart';
import 'package:summarize_app/views/pages/home/upload_pdf_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController myFeature = TextEditingController();
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
              Consumer<FirebaseAuthProvider>(
                builder: (context, auth, _) {
                  return UserHeader(
                    message: "Welcome ${auth.username}",
                  );
                },
              ),
              const DocumentView(),
              ActionButtons(myFeature: myFeature),
              const UploadView(),
            ],
          ),
        ),
      ),
    );
  }
}
