import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:flutter/material.dart';

class ResponseBuilder<T , E> extends StatelessWidget {
  final ResponseWrapper<T , E>? apiResponse;
  final void Function() onRefresh;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, Widget defaultLoadingWidget)? loadingBuilder;
  final Widget Function(BuildContext context, Widget defaultErrorWidget)? errorBuilder;
  const ResponseBuilder({
    required this.apiResponse,
    required this.onRefresh,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final response = apiResponse;
    final localLoadingBuilder = loadingBuilder;
    final localErrorBuilder = errorBuilder;

    return switch(response){
      ResponseSucceed() => builder(context, response.data),
      ResponseFailed() => localErrorBuilder == null ?
        DefaultErrorWidget(
          onTap: onRefresh,
          errorMessage: response.message ?? "Unknown Error",
        ) :
        localErrorBuilder(
          context,
          DefaultErrorWidget(
              onTap: onRefresh,
              errorMessage: response.message ?? "Unknown Error"
          ),
        ),

      ResponseLoading() || null => localLoadingBuilder == null ?
        const Center(
          child: CircularProgressIndicator(),
        ) :
        localLoadingBuilder(
            context,
            const Center(
              child: CircularProgressIndicator(),
            )
        ),
    };
  }
}