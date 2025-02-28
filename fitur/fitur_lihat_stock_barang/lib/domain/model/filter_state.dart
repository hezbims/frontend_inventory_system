class FilterState {
  final int categoryId;
  final String searchKeyword;
  final int pageNumber;
  FilterState({
    required this.categoryId,
    required this.searchKeyword,
    required this.pageNumber,
  });

  static FilterState init() => FilterState(
    categoryId: 0,
    searchKeyword: "",
    pageNumber: 1,
  );

  FilterState copyWith({
    final int? categoryId,
    final String? searchKeyword,
    final int? pageNumber,
  }){
    return FilterState(
      categoryId: categoryId ?? this.categoryId,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}