import 'dart:async';
import 'dart:html';
import 'dart:collection';

class WebSseClient {
  final _eventStreamController = StreamController<String>();
  final _httpRetryStream = StreamController<Pair<String , Map<String , String>?>>();
  HttpRequest? _httpRequest;
  
  WebSseClient(){
    _httpRetryStream.stream.listen((event) {
      _tryHttpRequest(url)
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

      if (textStream != null) {
        _eventStreamController.add(textStream);
        // final parsedData = _mapper.parseData(textStream);
        // if (parsedData != null) {
        //   _streamController?.add(parsedData);
        // }
      }
    });

    _httpRequest?.onError.listen((event) {
      _httpRequest?.abort();
      _httpRetryStream.add(true);
    });
    _httpRequest?.send();
  }

  Stream<String> getWebSse(String url , { Map<String , String>? headers }) {
    _httpRetryStream.add(true);
    return _eventStreamController.stream;
  }
}