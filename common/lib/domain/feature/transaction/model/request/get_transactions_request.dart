class GetTransactionsRequest {
  final int? lastUpdate;
  final int? lastId;
  GetTransactionsRequest({
    required this.lastUpdate,
    required this.lastId,
  });

  static GetTransactionsRequest getDefault(){
    return GetTransactionsRequest(lastUpdate: null, lastId: null);
  }
}