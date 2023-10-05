import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/constant/themes/theme_color.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
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
    final arg = ModalRoute.of(context)?.settings.arguments
      as GeneratePdfParameterDto;

    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<PreviewLaporanProvder>(param1: arg),
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
