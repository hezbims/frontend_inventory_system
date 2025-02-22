class MyLatestQueueDebouncerHelper<T> {
  Future<T> Function()? latestPendingProcess;
  Future<T>? onGoingProcess;

  void run({
    required Future<T> Function() process,
    required void Function(T) onDone,
  }) async {
    latestPendingProcess = process;
    await onGoingProcess;
    if (latestPendingProcess != process) {
      return;
    }
    
    onGoingProcess = process();
    onGoingProcess?.then(onDone);
  }
}