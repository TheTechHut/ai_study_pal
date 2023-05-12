import 'dart:io';
import 'package:summarize_app/services/toast/toast_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchWhatsApp {
  static launchWhatsApp({required String featureMessage}) async {
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
