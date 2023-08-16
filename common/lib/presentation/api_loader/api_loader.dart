import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class ApiLoader<T> extends StatelessWidget {
  final Future<ApiResponse> apiResponse;
  final void Function() onRefresh;
  final Widget Function(T data) builder;
  const ApiLoader({
    required this.apiResponse,
    required this.onRefresh,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiResponse,
      builder: (context , snapshot){
        if (snapshot.hasData){
          final response = snapshot.data!;
          if (response is ApiResponseSuccess){
            return builder(response.data);
          }
          else if (response is ApiResponseFailed) {
            return Center(
              child: DefaultErrorWidget(
                onTap: onRefresh,
                errorMessage: response.message ?? "Unknown Error",
              ),
            );
          }
          else {
            throw Exception("Enggak mungkin T_T");
          }
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
