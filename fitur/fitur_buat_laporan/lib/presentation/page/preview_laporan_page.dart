import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/themes/theme.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_buat_laporan/data/repository/get_data_laporan_repository_impl.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/presentation/provider/preview_laporan_provider.dart';
import 'package:fitur_buat_laporan/presentation/utils/generate_pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PreviewLaporanPage extends StatelessWidget {
  const PreviewLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO : Buat test untuk mastiin parameter pasti ke pass
    final param = ModalRoute.of(context)?.settings.arguments as GeneratePdfParameterDto;

    return ChangeNotifierProvider(
      create: (context) => PreviewLaporanProvder(
        repository: GetDataLaporanRepositoryImpl(),
        param: param,
      ),
      child: Consumer<PreviewLaporanProvder>(
        builder: (context , provider , child) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              scrolledUnderElevation: 0,
            ),
            body:
            PdfPreview(
              onError: (context , error){
                return DefaultErrorWidget(
                  onTap: provider.refresh,
                  errorMessage: error.toString(),
                );
              },
              initialPageFormat: PdfPageFormat.a4,
              build: (pageFormat) async {
                return generatePdf (
                  pageFormat: pageFormat,
                  period: provider.period,
                  apiResponse: await provider.dataLaporanResponse
                );
              }
            ),
          );
        }
      ),
    );
  }
}
