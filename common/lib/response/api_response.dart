abstract class ApiResponse {}

class ApiResponseSuccess<T> implements ApiResponse {
  final T data;
  ApiResponseSuccess({
    required this.data,
  });
}

class ApiResponseFailed implements ApiResponse {
  final String? message;
  final int? statusCode;
  ApiResponseFailed({
    this.message,
    this.statusCode,
  });
}

