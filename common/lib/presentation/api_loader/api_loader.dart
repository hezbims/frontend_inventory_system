import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class ApiLoader<T> extends StatelessWidget {
  final Future<ApiResponse> apiResponse;
  final void Function() onRefresh;
  final Widget Function(T data) builder;
  final bool useScaffold;
  const ApiLoader({
    required this.apiResponse,
    required this.onRefresh,
    required this.builder,
    this.useScaffold = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiResponse,
      builder: (context , snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          final response = snapshot.data!;
          if (response is ApiResponseSuccess){
            return builder(response.data);
          }
          else if (response is ApiResponseFailed) {
            if (useScaffold){
              return Scaffold(
                body: DefaultErrorWidget(
                  onTap: onRefresh,
                  errorMessage: response.error ?? "Unknown Error",
                ),
              );
            }
            return DefaultErrorWidget(
              onTap: onRefresh,
              errorMessage: response.error ?? "Unknown Error",
            );
          }
          else {
            throw Exception("Enggak mungkin T_T");
          }
        }
        else {
          if (useScaffold) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
