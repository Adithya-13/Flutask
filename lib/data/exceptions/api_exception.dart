class APIException implements Exception {
  final String message;
  final int statusCode;
  final String statusText;

  APIException(this.message, this.statusCode, this.statusText);
}

String errorAPI(e) => (e is APIException) ? e.message : e.toString();