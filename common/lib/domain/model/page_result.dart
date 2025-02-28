class PageResult<T> {
  final List<T> listData;
  final PageLinks links;

  PageResult({
    required this.listData,
    required this.links,
  });
  
  PageResult<E> mapData<E>(E Function(T) mapper){
    return PageResult(
      listData: listData.map((data) => mapper(data)).toList(),
      links: links
    );
  }
}

class PageLinks {
  final int currentPage;
  final int? nextPage;
  final int? prevPage;
  final int lastPage;

  PageLinks({
    required this.currentPage,
    required this.nextPage,
    required this.prevPage,
    required this.lastPage,
  });
}