class GetTransactionsRequest {
  int? _lastUpdate;
  int? get lastUpdate => _lastUpdate;

  int? _lastId;
  int? get lastId => _lastId;

  String _searchKeyword = "";
  String get searchKeyword => _searchKeyword;

  int? _idPengaju;
  int? get idPengaju => _idPengaju;

  void setNextPageKey({
    required int lastUpdate,
    required int lastId,
  }){
    _lastUpdate = lastUpdate;
    _lastId = lastId;
  }

  void setSearchKeyword(String searchKeyword) => _searchKeyword = searchKeyword;

  void setIdPengaju(int? idPengaju) => _idPengaju = idPengaju;
}