class Response {
  static const int success = 200;
  static const int badRequest = 400;
  static const int notFound = 404;
  static const int internalServerError = 500;

  static HttpResponse build({
    bool status: true,
    dynamic data: const {},
    String message: '',
    int code: success,
  }) {
    return HttpResponse(
      status: status,
      data: data,
      message: message,
      code: code,
    );
  }
}

class HttpResponse {
  final bool status;
  final dynamic data;
  final String message;
  final int code;

  HttpResponse({this.status, this.data, this.message, this.code});
}
