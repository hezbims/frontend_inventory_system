/// event dari provider ke paging controller untuk infinite scroll pagination
sealed class PageEvent<T> {}

class PageDataArrive<T> extends PageEvent<T>{
  final T data;
  final bool isLast;
  PageDataArrive({required this.data, required this.isLast});
}

class PageError<T> extends PageEvent<T> {
  final String? message;
  PageError(this.message);
}

class PageRefreshRequest<T> extends PageEvent<T>{}