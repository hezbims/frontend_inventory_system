import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';

class GetBarangPaginateUseCase {
  final IBarangRepository _repository;
  GetBarangPaginateUseCase({
    required IBarangRepository repository
  }) : _repository = repository;

  Future<ApiResponse> fetch({
    required int pageNumber,
    required String keyword,
  }) {
    return _repository.getStockBarang(pageNumber , keyword);
  }
}