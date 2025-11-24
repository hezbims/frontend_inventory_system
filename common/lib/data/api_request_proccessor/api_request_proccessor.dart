import 'dart:async';

import 'package:common/data/mapper/other/message_mapper.dart';
import 'package:common/data/mapper/other/pagination_checker.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/http.dart';
import 'package:flutter/material.dart';

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
        debugPrint("api request processor responded failed(${response.statusCode}) : ${response.body}");
        return ApiResponseFailed(
          error: getErrorMessageFromBody == null ?
            DefaultMessageMapper.getMessageFromBody(response.body) :
            getErrorMessageFromBody(response.body),
          statusCode: response.statusCode,
        );
      }
    } on ClientException catch(e) {
      return ApiResponseFailed(error: 'Gagal tersambung ke server : ${e.message}');
    } catch (e) {
      debugPrint("api request unknown fail : $e");
      return ApiResponseFailed(
        error: "$repositoryName : $e",
      );
    }

  }

  static Future<ResponseWrapper<ModelType, ErrorType?>> processV2<ModelType , ErrorType>({
    required final Future<Response> apiRequest,
    required final ModelType Function(Response) getModelFromBody,
    final ErrorType? Function(Response)? getErrorMessageFromBody,
    final String? repositoryName,
  }) async {
    try {
      final response = await apiRequest;
      if (response.statusCode < 300) {
        return ResponseSucceed(data: getModelFromBody(response),);
      } else {
        debugPrint("api request processor responded failed(${response.statusCode}) : ${response.body}");
        return ResponseFailed(
          error: getErrorMessageFromBody != null ?
            getErrorMessageFromBody(response) : null,
        );
      }
    } on ClientException catch(e) {
      return ResponseFailed(message: 'Failed to connect to server : ${e.message}', error: null);
    } catch (e) {
      debugPrint("api request unknown fail : $e");
      return ResponseFailed(message: "$repositoryName : $e", error: null);
    }
  }
}