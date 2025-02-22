sealed class ApiResponse {}

class ApiResponseSuccess<T> implements ApiResponse {
  final T? data;
  bool isNextDataExist;
  ApiResponseSuccess({
    this.data,
    this.isNextDataExist = false,
  });
}

class ApiResponseFailed<T> implements ApiResponse {
  final T? error;
  final int? statusCode;
  ApiResponseFailed({
    this.error,
    this.statusCode,
  });
}

class ApiResponseLoading implements ApiResponse {}

