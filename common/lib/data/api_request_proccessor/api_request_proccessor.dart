import 'package:common/data/mapper/message_mapper.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/http.dart';

abstract class ApiRequestProcessor {
  static Future<ApiResponse> process<T>({
    required Future<Response> apiRequest,
    required T Function(String)? getModelFromBody,
    String? repositoryName,
  }) async {
    try {
      final response = await apiRequest;
      if (response.statusCode < 300) {
        return ApiResponseSuccess(
          data: getModelFromBody == null ?
            null :
            getModelFromBody(response.body),
        );
      } else {
        return ApiResponseFailed(
          message: MessageMapper.getMessageFromBody(response.body),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponseFailed(
        message: "$repositoryName : $e",
      );
    }

  }
}