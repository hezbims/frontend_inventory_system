import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_pengajuan/data/api_client/lihat_pengajuan_api_client.dart';
import 'package:fitur_lihat_pengajuan/data/mapper/pengajuan_preview_mapper.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_lihat_pengajuan_repository.dart';
import 'package:flutter/material.dart';

class LihatPengajuanRepositoryImpl implements ILihatPengajuanRepository {
  final _mapper = PengajuanPreviewMapper();
  final _apiClient = LihatPengajuanApiClient();
  @override
  Future<ApiResponse> getPengajuanPreview({
    required int pageNumber,
    required String keyword,
  }) {
    debugPrint('lihat pengajuan repository');
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getPengajuanPreview(
        pageNumber: pageNumber,
        keyword: keyword
      ),
      getModelFromBody: _mapper.fromBodyToPengajuanPreview,
      isPagination: true,
    );
  }

}