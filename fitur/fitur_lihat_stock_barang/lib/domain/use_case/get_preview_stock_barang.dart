import 'package:common/domain/model/page_result.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:fitur_lihat_stock_barang/domain/model/filter_state.dart';
import 'package:fitur_lihat_stock_barang/domain/model/preview_barang.dart';
import 'package:fitur_lihat_stock_barang/data/mapper/preview_barang_mapper.dart';

class GetPreviewStockBarang {
  final IBarangRepository _repository;
  GetPreviewStockBarang({
    required IBarangRepository repository
  }) : _repository = repository;

  Future<ResponseWrapper<PageResult<PreviewBarang>, Object>> execute(FilterState filterState) async {
    final response = await _repository.getStockBarangPaginatedV2(
      pageNumber: filterState.pageNumber,
      keyword: filterState.searchKeyword,
      idKategori: filterState.categoryId,
    );
    return response.mapPageData((barang) => barang.toPreviewBarang());
  }
}