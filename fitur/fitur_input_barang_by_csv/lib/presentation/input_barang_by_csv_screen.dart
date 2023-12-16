import 'dart:math';

import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/dotted_border.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_barang_by_csv/presentation/input_barang_by_csv_provider.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvScreen extends StatelessWidget {
  const InputBarangByCsvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<InputBarangByCsvProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Input Barang by CSV'),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        body: Center(
          child: Consumer<InputBarangByCsvProvider>(
            builder: (context , provider , child) {
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: max(
                    24,
                    (MediaQuery.of(context).size.width - 582) / 2
                  ),
                ),
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: provider.downloadTemplate,
                          child: const Text('Download Template')
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),

                  const SizedBox(height: 8,),

                  InkWell(
                    onTap: provider.pickFile,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      dashPattern: const [12 , 12],
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (provider.choosenFile == null) ...[
                              const Icon(
                                Icons.add_circle_outline,
                                size: 36,
                              ),
                              const SizedBox(height: 16,),
                              const Text('Tarik atau pilih file .csv')
                            ]
                            else ...[
                              const Icon(
                                Icons.description_outlined,
                                size: 36,
                              ),
                              const SizedBox(height: 16,),
                              Text(
                                '${provider.choosenFile?.name}, '
                                '${(provider.choosenFile?.size ?? 0 / 1000)
                                  .toStringAsFixed(1)}.Kb'
                              )
                            ],
                          ]
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: provider.overrideDataOnSubmit,
                                  onChanged: provider.onChangeOverrideDataOnSubmit
                                ),

                                const SizedBox(width: 2,),

                                const Expanded(
                                  child: Text(
                                    'Timpa data apabila nama atau kode barang sama',
                                    style: TextStyle(
                                        fontSize: 13
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            RichText(
                              text: const TextSpan(
                                text: '*',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                ),
                                children: [
                                  TextSpan(
                                    text: ') jika ini tidak dicentang, '
                                        'maka transaksi akan dibatalkan '
                                        'apabila ada nama atau kode '
                                        'barang yang sama',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: CustomFontWeight.light,
                                    ),
                                  ),
                                ]
                              )
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24,),

                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                        ),
                        onPressed: provider.onSubmmit,
                        child:
                          provider.uploadByExcelResponse is ApiResponseLoading ?
                            const CircularProgressIndicator() :
                            const Text('Submit'),
                      ),
                    ],
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
