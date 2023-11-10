import 'dart:async';
import 'package:common/utils/pair.dart';
import 'package:dependencies/universal_html.dart';

class WebSseClient {
  final _eventStreamController = StreamController<String>();
  final _httpRetryStream = StreamController<Pair<String , Map<String , String>?>>();
  HttpRequest? _httpRequest;
  
  WebSseClient(){
    _httpRetryStream.stream.listen((event) {
      _tryHttpRequest(event.first , headers: event.second);
    });
  }
  void dispose(){
    _eventStreamController.close();
    _httpRetryStream.close();
    _httpRequest?.abort();
  }
  
  void _tryHttpRequest(String url , { Map<String , String>? headers }){
    _httpRequest = HttpRequest();

    _httpRequest?.open("GET", url);
    headers?.forEach((key, value) {
      _httpRequest?.setRequestHeader(key, value);
    });

    int progress = 0;
    _httpRequest?.onProgress.listen((event) {
      final textStream = _httpRequest?.responseText!.substring(progress);
      progress += textStream?.length ?? 0;

      if (textStream != null) { _eventStreamController.add(textStream); }
    });

    _httpRequest?.onError.listen((event) {
      _httpRequest?.abort();
      Future.delayed(
        const Duration(seconds: 10),
        () => _httpRetryStream.add(Pair(url, headers))
      );
    });
    _httpRequest?.send();
  }

  Stream<String> getSse(String url , { Map<String , String>? headers }) {
    _httpRetryStream.add(Pair(url, headers));
    return _eventStreamController.stream;
  }
}