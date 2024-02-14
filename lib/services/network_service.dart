import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ai_study_pal/services/network_helper.dart';
import 'package:ai_study_pal/services/toast_service.dart';

enum RequestType {
  post,
  get,
}

class NetworkService {
  NetworkService({required this.body, required this.headers});

  final Map<String, dynamic> body;
  final Map<String, String> headers;

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    } else if (requestType == RequestType.post) {
      final requestBody = jsonEncode(body);
      return http.post(uri, headers: headers, body: requestBody);
    }
    return null;
  }

  Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String uri,
    Map<String, String>? queryParam,
  }) async {
    try {
      final header = headers;
      final url = NetworkHelper.concatUrlQP(url: uri, queryParam: queryParam);
      final body = this.body;

      final response = await _createRequest(
        requestType: requestType,
        uri: Uri.parse(url),
        headers: header,
        body: body,
      );
      return response;
    } catch (e) {
      log('Error - $e');
      showToast("Check your internet connection and try again");
      return null;
    }
  }
}
