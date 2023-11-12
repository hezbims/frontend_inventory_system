import 'dart:async';
import 'dart:convert';

import 'package:common/utils/pair.dart';
import 'package:dependencies/http.dart';

class MobileSseClient {
  Timer? _timer;
  final _eventStreamController = StreamController<String>();
  final _httpRetryStream = StreamController<Pair<String , Map<String , String>?>>();

  void dispose(){
    _timer?.cancel();
    _eventStreamController.close();
    _httpRetryStream.close();
  }

  MobileSseClient(){
    _httpRetryStream.stream.listen((event) {
      _tryHttpRequest(event.first , headers: event.second);
    });
  }

  void _tryHttpRequest(String url , {Map<String , String>? headers}) async {
    final request = Request('GET', Uri.parse(url));

    headers?.forEach((key, value) {
      request.headers[key] = value;
    });

    try {
      final response = await Client().send(request);
      if (response.statusCode != 200){
        _retryInTenSeconds(url, headers);
      }
      else {
        response.stream.listen(
          (value) {
            final decodedText = utf8.decode(value);
            if (!_eventStreamController.isClosed) {
              _eventStreamController.add(decodedText);
            }
          },
          onError: (error , stacktrace){
            _retryInTenSeconds(url, headers);
          },
          cancelOnError: true,
        );
      }
    } catch (e){
      _retryInTenSeconds(url, headers);
    }
  }

  void _retryInTenSeconds(String url, Map<String , String>? headers){
    _timer = Timer(
      const Duration(seconds: 10),
      () => _httpRetryStream.add(Pair(url, headers))
    );
  }

  Stream<String>  getSse(String url , {Map<String , String>? headers}) {
    _httpRetryStream.add(Pair(url, headers));
    return _eventStreamController.stream;
  }
}