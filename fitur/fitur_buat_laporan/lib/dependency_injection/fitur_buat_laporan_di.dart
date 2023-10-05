import 'package:dependencies/get_it.dart';
import 'package:fitur_buat_laporan/data/repository/get_data_laporan_repository_impl.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';
import 'package:fitur_buat_laporan/presentation/provider/preview_laporan_provider.dart';

void fiturBuatLaporanDi(){
  GetIt.I.registerFactory<IGetDataLaporanRepository>(
    () => GetDataLaporanRepositoryImpl()
  );

  GetIt.I.registerFactoryParam(
    (GeneratePdfParameterDto param, _) => PreviewLaporanProvder(
      repository: GetIt.I.get(), param: param
    ),
  );
}