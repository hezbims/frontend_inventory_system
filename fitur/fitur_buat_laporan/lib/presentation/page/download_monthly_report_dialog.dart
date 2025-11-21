import 'package:common/constant/themes/custom_sizing.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_buat_laporan/data/repository/get_data_laporan_repository_impl.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:fitur_buat_laporan/presentation/provider/pilih_bulan_tahun_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DownloadMonthlyReportDialog extends StatelessWidget {

  const DownloadMonthlyReportDialog({super.key});

  /// `CustomSizing.maxPhonePotraitWidth` - 72
  final double _componentWidth = CustomSizing.maxPhonePotraitWidth - 72;
  /// 8
  final double _componentHorizontalSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CustomSizing.maxPhoneLandscapeWidth,
      child: ChangeNotifierProvider(
        create: (context) => PilihBulanTahunProvider(
            repository: GetDataLaporanRepositoryImpl()
        ),
        child: Consumer<PilihBulanTahunProvider>(
            builder: (context , provider , child) {

              if (provider.goNext){
              }
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Download Monthly Report",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),

                        IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close_outlined),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24,),

                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: _componentHorizontalSpacing,
                        children: [
                          SizedBox(
                            width: _componentWidth,
                            child: CustomDropdownMenu(
                                label: "Month",
                                value: provider.choosenMonth,
                                values: Month.values,
                                onValueChange: provider.onChangeChoosenMonth,
                                errorText: null
                            ),
                          ),

                          SizedBox(
                            width: _componentWidth,
                            child: CustomTextfield(
                              controller: provider.yearController,
                              label: "Year",
                              errorText: provider.yearError,
                              inputType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16,),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (kIsWeb)
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: _componentWidth),
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF0C7E00),
                                ),
                                onPressed: provider.downloadCSV,
                                child: const Row(
                                  children: [
                                    Icon(Icons.table_chart_outlined),
                                    SizedBox(width: 8,),
                                    Text("CSV")
                                  ],
                                )
                              ),
                            ),
                          ),

                        SizedBox(width: _componentHorizontalSpacing,),

                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: _componentWidth),
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFAE0000),
                              ),
                              onPressed: (){},
                              child: const Row(
                                children: [
                                  Icon(Icons.picture_as_pdf_outlined),
                                  SizedBox(width: 8,),
                                  Text("PDF")
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
