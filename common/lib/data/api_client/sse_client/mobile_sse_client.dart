import 'dart:async';
import 'dart:convert';

import 'package:common/utils/pair.dart';
import 'package:dependencies/http.dart';

class MobileSseClient {
  final _eventStreamController = StreamController<String>();
  final _httpRetryStream = StreamController<Pair<String , Map<String , String>?>>();

  void dispose(){
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
        Future.delayed(
          const Duration(seconds: 10),
          () => _httpRetryStream.add(Pair(url, headers))
        );
      }
      else {
        response.stream.listen((value) {
          final decodedText = utf8.decode(value);
          _eventStreamController.add(decodedText);
        });
      }
    } catch (e){
      Future.delayed(
        const Duration(seconds: 10),
        () => _httpRetryStream.add(Pair(url, headers))
      );
    }
  }

  Stream<String>  getSse(String url , {Map<String , String>? headers}) {
    _httpRetryStream.add(Pair(url, headers));
    return _eventStreamController.stream;
  }
}