import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_buat_laporan/data/repository/get_data_laporan_repository_impl.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:fitur_buat_laporan/presentation/provider/pilih_bulan_tahun_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PilihTahunBulanPage extends StatelessWidget {
  const PilihTahunBulanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const StockBottomNavBar(
        currentIndex: Routes.fiturBuatLaporanIndex
      ),
      body: ChangeNotifierProvider(
        create: (context) => PilihBulanTahunProvider(
          repository: GetDataLaporanRepositoryImpl()
        ),
        child: Consumer<PilihBulanTahunProvider>(
          builder: (context , provider , child) {
            if (provider.goNext){
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  provider.goNext = false;
                  Navigator.of(context).pushNamed(
                    Routes.previewLaporanRoute,
                    arguments: provider.pdfParameter,
                  );
                }
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).maxHorizontalPadding + 24
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropdownMenu(
                          label: "Bulan",
                          value: provider.choosenMonth,
                          values: Month.values,
                          onValueChange: provider.onChangeChoosenMonth,
                          errorText: null
                        )
                      ),

                      const HorizontalFormSpacing(),

                      Expanded(
                        child: CustomTextfield(
                          controller: provider.yearController,
                          label: "Tahun",
                          errorText: provider.yearError,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const VerticalFormSpacing(),

                  SizedBox(
                    width: double.infinity,
                    child: SubmitButton(
                      label: "Cetak Laporan",
                      onTap: provider.submit
                    ),
                  ),

                  const VerticalFormSpacing(),

                  SizedBox(
                    width: double.infinity,
                    child: kIsWeb ?
                      SubmitButton(
                        label: "Download CSV",
                        onTap: provider.downloadCSV
                      ) :
                      const DisabledSubmitButton(label: 'Download CSV',),
                  ),

                ],
              ),
            );
          }
        ),
      )
    );
  }
}
