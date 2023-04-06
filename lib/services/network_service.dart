import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:summarize_app/services/network_helper.dart';
import 'package:summarize_app/services/toast_service.dart';

enum RequestType {
  post,
  get,
}

class NetworkService {
  NetworkService(this._body);
  Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer <API KEY>',
  };
  final Map<String, dynamic> _body;
  Map<String, String> get getHeaders => _headers;

  void setHeaders({required Map<String, String> headers}) {
    _headers = headers;
  }

  Map<String, dynamic> get getBody => _body;

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
      final header = _headers;
      final url = NetworkHelper.concatUrlQP(url: uri, queryParam: queryParam);
      final body = _body;

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
