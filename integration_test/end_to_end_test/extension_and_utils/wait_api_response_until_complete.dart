import 'package:common/response/api_response.dart';

Future<void> waitUntilApiResponseComplete(
  ApiResponse? Function() getApiResponse,
) async {
  await Future.delayed(const Duration(milliseconds: 200));
  while (getApiResponse() is ApiResponseLoading){
    await Future.delayed(const Duration(milliseconds: 500));
  }
}