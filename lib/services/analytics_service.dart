import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static logSummaryEvent(bool isSummarized) async {
    await _analytics.logEvent(name: "summarized_file", parameters: {
      'summarized': isSummarized,
    });
  }

  static logGenQuestionEvent(bool isAsked) async {
    await _analytics.logEvent(name: "summarized_file", parameters: {
      'asked_question': isAsked,
    });
  }

  static FirebaseAnalyticsObserver getObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}
