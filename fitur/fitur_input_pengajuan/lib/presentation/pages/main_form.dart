import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/card/status_mini_card.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/clock_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/barang_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/date_field.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';

class MainForm extends StatelessWidget {
  final Pengajuan? initialData;
  const MainForm({
    super.key,
    required this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GetIt.I.get<MainFormProvider>(param1: initialData),
        child: Consumer<MainFormProvider>(
          builder: (context, provider, child) {
            if (provider.submitResponse is ApiResponseSuccess) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pop(true),
              );
            }
            return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                centerTitle: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Form Input Transaksi"),
                    if (provider.status != null)
                      StatusMiniCard(status: provider.status!),
                  ],
                ),
                actions: [
                  if (provider.status != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 24),
                        child: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.delete , color: Colors.red,)
                        ),
                      ),
                    )
                ],
                leading: const BackButton(),
              ),
              bottomNavigationBar: SubmitCard(
                button: provider.useDisabledButton ?
                DisabledSubmitButton(label: provider.submitButtonLabel,) :
                SubmitButton(
                  onTap: provider.submit,
                  label: provider.submitButtonLabel,
                ),
              ),
              body: Builder(
                builder: (context) {
                  final listItem = [
                    Row(
                      children: [
                        Expanded(
                          child: DateField(
                            errorMessage: provider.tanggalError,
                            value: provider.tanggal,
                            onValueChange: provider.onTanggalChange,
                          ),
                        ),

                        const HorizontalFormSpacing(),

                        Expanded(
                          child: ClockField(
                            errorMessage: provider.jamError,
                            value: provider.jam,
                            onValueChange: provider.onJamChange
                          ),
                        ),
                      ],
                    ),

                    CustomDropdownMenu(
                      label: "Tipe pengajuan",
                      value: provider.currentTipePengajuan,
                      values: provider.tipePengajuanList,
                      onValueChange: provider.onTipePengajuanChange,
                      errorText: provider.tipePengajuanError
                    ),

                    if (provider.isPemasukan == true) ...[
                      DropdownPageChooser(
                        label: "Nama pemasok",
                        value: provider.pemasok?.nama ?? "",
                        errorMessage: provider.pemasokError,
                        onTap: () async {
                          // Warning, jangan pernah push page ini dengan named route!!!
                          // hal ini untuk keselamatan data ketika refresh
                          final pemasokPicked = await Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) =>
                                  const PilihPengajuPage(isPemasok: true),
                            ),
                          );
                          if (pemasokPicked is Pengaju) {
                            provider.onChangePemasok(pemasokPicked);
                          }
                        }
                      ),
                    ]
                    else
                      if (provider.isPemasukan == false) ...[
                        DropdownPageChooser(
                          label: "Group",
                          value: provider.group?.nama ?? "",
                          errorMessage: provider.groupError,
                          onTap: () async {
                            final groupPicked = await Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                    const PilihPengajuPage(isPemasok: false),
                                ),
                              );

                            if (groupPicked is Pengaju) {
                              provider.onChangeGroup(groupPicked);
                            }
                          }
                        ),
                      ],

                    if (provider.isPemasukan != null)
                      ListBarangFormField(
                        listBarangTransaksi: provider.listBarangTransaksi
                      ),
                  ];

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).phoneLandscapePadding,
                        vertical: 36
                    ),
                    itemBuilder: (context , index){
                      return listItem[index];
                    },
                    separatorBuilder: (context, index){
                      return const VerticalFormSpacing();
                    },
                    itemCount: listItem.length,
                  );
                }
              ),
            );
          }
        )
    );
  }
}
