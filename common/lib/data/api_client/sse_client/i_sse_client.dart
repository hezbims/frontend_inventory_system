import 'dart:async';

abstract class ISseClient {
  final _retrySteram = StreamController<bool>();
  ISseClient(){
    _re
  }

  void dispose(){

  }
}
