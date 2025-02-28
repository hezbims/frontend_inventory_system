import 'package:common/domain/model/page_result.dart';

sealed class ResponseWrapper<T , E>{
}

class ResponseSucceed<T , E> implements ResponseWrapper<T , E>{
  final T data;
  ResponseSucceed({required this.data});
}

class ResponseFailed<T , E> implements ResponseWrapper<T , E>{
  E? error;
  int? errorCode;
  String? message;
  ResponseFailed({this.error, this.errorCode, this.message});
}

class ResponseLoading<T , E> implements ResponseWrapper<T , E>{
  final String? progress;
  ResponseLoading({this.progress});
}

extension ResponseWrapperExtension<T, E> on ResponseWrapper<T , E> {
  ResponseWrapper<V , E> mapData<V>(V Function(T) mapper){
    final currentResponse = this;
    return switch(currentResponse){
      ResponseSucceed() => ResponseSucceed(data: mapper(currentResponse.data)),
      ResponseFailed() => ResponseFailed(
        error: currentResponse.error,
        message: currentResponse.message,
        errorCode: currentResponse.errorCode,
      ),
      ResponseLoading() => ResponseLoading(progress: currentResponse.progress),
    };
  }
}

extension ResponseWrapperPagingExtension<T, E> on ResponseWrapper<PageResult<T>, E> {
  ResponseWrapper<PageResult<V> , E> mapPageData<V>(V Function(T) mapper){
    final currentResponse = this;
    return switch(currentResponse){
      ResponseSucceed() => ResponseSucceed(data: currentResponse.data.mapData(mapper)),
      ResponseFailed() => ResponseFailed(
        error: currentResponse.error,
        errorCode: currentResponse.errorCode,
        message: currentResponse.message,
      ),
      ResponseLoading() => ResponseLoading(progress: currentResponse.progress),
    };
  }
}