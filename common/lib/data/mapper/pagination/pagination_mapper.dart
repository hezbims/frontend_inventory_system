import 'package:common/domain/model/page_result.dart';

abstract class PaginationMapper {
  static PageLinks getPageLinks(dynamic jsonBody){
    final links = jsonBody['links'];
    return PageLinks(
      currentPage: links['current_page'],
      nextPage: links['next_page'],
      prevPage: links['prev_page'],
      lastPage: links['total_page'],
    );
  }
}