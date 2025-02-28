import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class ApiResponseLoaderV2<T> extends StatelessWidget {
  final ApiResponse? apiResponse;
  final void Function() onRefresh;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, Widget defaultLoadingWidget)? loadingBuilder;
  final Widget Function(BuildContext context, Widget defaultErrorWidget)? errorBuilder;
  const ApiResponseLoaderV2({
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
      ApiResponseSuccess<T>() => builder(context, response.data as T),

      ApiResponseFailed() => localErrorBuilder == null ?
        DefaultErrorWidget(
            onTap: onRefresh,
            errorMessage: response.error ?? "Unknown Error",
        ) :
        localErrorBuilder(
          context,
          DefaultErrorWidget(
            onTap: onRefresh,
            errorMessage: response.error ?? "Unknown Error"
          ),
        ),

      ApiResponseLoading() || null => localLoadingBuilder == null ?
        const Center(
          child: CircularProgressIndicator(),
        ) :
        localLoadingBuilder(
          context,
          const Center(
            child: CircularProgressIndicator(),
          )
        ),

      _ => throw Exception("Unknown Error occured")
    };
  }
}