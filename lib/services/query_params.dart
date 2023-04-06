class QueryParams {
  QueryParams._();
  Map<String, String> _queryParams = {};
  void setapiQp({required Map<String, String> queryParams}) =>
      _queryParams = queryParams;

  Map<String, String> getQueryParam() {
    return _queryParams;
  }
}
