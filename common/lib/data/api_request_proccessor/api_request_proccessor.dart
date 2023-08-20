import 'package:common/data/mapper/message_mapper.dart';
import 'package:common/data/mapper/pagination_checker.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/http.dart';

abstract class ApiRequestProcessor {
  static Future<ApiResponse> process<ModelType , ErrorType>({
    required Future<Response> apiRequest,
    ModelType Function(String)? getModelFromBody,
    ErrorType? Function(String)? getErrorMessageFromBody,
    bool isPagination = false,
    String? repositoryName,
  }) async {
    try {
      final response = await apiRequest;
      if (response.statusCode < 300) {
        return ApiResponseSuccess(
          data: getModelFromBody == null ?
            null :
            getModelFromBody(response.body),
          isNextDataExist: isPagination ?
            PaginationChecker.hasNext(response.body) :
            false
        );
      } else {
        return ApiResponseFailed(
          error: getErrorMessageFromBody == null ?
            DefaultMessageMapper.getMessageFromBody(response.body) :
            getErrorMessageFromBody(response.body),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponseFailed(
        error: "$repositoryName : $e",
      );
    }

  }
}