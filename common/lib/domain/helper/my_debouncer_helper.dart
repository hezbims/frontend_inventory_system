class MyLatestQueueDebouncerHelper {
  Future Function()? _latestPendingProcess;
  Future? _onGoingProcess;

  void run<T>({
    required Future<T> Function() process,
    void Function(T)? onDone,
  }) async {
    _latestPendingProcess = process;
    await _onGoingProcess;
    if (_latestPendingProcess != process) {
      return;
    }
    
    _onGoingProcess = process();

    _onGoingProcess?.then((result){onDone?.call(result);});
  }
}