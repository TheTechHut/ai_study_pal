import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static logSummaryEvent(bool isSummarized) async {
    await _analytics.logEvent(name: "summarized_file", parameters: {
      'summarized': "Text was summarized ${isSummarized.toString()}",
    });
  }

  static logGenQuestionEvent(bool isAsked) async {
    await _analytics.logEvent(name: "summarized_file", parameters: {
      'asked_question': "Question was ${isAsked.toString()}",
    });
  }

  static FirebaseAnalyticsObserver getObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}
