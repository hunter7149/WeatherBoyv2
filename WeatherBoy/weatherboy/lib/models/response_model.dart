enum ResponseStatus { success, failed }

class ResponseModel {
  final ResponseStatus status;
  final String message;
  final dynamic data;

  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
}
