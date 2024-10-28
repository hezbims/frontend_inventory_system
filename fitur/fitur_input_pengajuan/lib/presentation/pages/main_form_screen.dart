import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/card/status_mini_card.dart';
import 'package:common/presentation/loader_overlay/loader_overlay.dart';
import 'package:common/presentation/provider/refresh_notifier.dart';
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
import 'package:fitur_input_pengajuan/presentation/component/main_form/delete_pengajuan_dialog.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_screen.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';

class MainFormScreen extends StatelessWidget {
  final Pengajuan? initialData;
  const MainFormScreen({
    super.key,
    required this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GetIt.I.get<MainFormProvider>(param1: initialData),
        child: Consumer<MainFormProvider>(
          builder: (context, provider, child) {
            if (
              provider.submitResponse is ApiResponseSuccess ||
              provider.deletePengajuanResponse is ApiResponseSuccess
            ) {
              final refreshNotifier = context.read<RefreshNotifier>();
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  refreshNotifier.notifyListeners();
                  Navigator.of(context).pop();
                }
              );
            }

            return LoaderOverlay(
              isLoading: provider.deletePengajuanResponse is ApiResponseLoading,
              child: Scaffold(
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
                    if (provider.canDeletePengajuan())
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 24),
                        child: IconButton(
                          onPressed: () async {
                            final willDelete = await DeletePengajuanDialog(
                                context: context
                            ).show();

                            if (willDelete == true){
                              provider.deletePengajuan();
                            }
                          },
                          icon: const Icon(Icons.delete , color: Colors.red,)
                        ),
                      )
                  ],
                  leading: const BackButton(),
                ),
                bottomNavigationBar: SubmitCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: provider.submitResponse is ApiResponseLoading ?
                      [const CircularProgressIndicator()] :
                      _getSubmitButtons(
                        isAdmin: provider.user.isAdmin,
                        currentStatus: provider.status,
                        onSubmit: provider.submit,
                        onTolak: provider.tolak,
                        context: context,
                      ),
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
                                    const PilihPengajuScreen(isPemasok: true),
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
                                      const PilihPengajuScreen(isPemasok: false),
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
                          horizontal: MediaQuery.of(context).phoneWidthLandscapePadding,
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
              ),
            );
          }
        )
    );
  }

  List<Widget> _getSubmitButtons({
    required bool isAdmin,
    required StatusPengajuan? currentStatus,
    required void Function()? onSubmit,
    required void Function()? onTolak,
    required BuildContext context,
  }){
    if (currentStatus == null){
      return [Expanded(child: SubmitButton(onTap: onSubmit, label: "Submit",))];
    }
    if (isAdmin){
      return switch(currentStatus){
        StatusPengajuan.menunggu => [
          Expanded(
            child: OutlinedButton(
              onPressed: onTolak!,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12,),
                ),
                side: const BorderSide(color: Colors.redAccent)
            ),
              child: const Text('Tolak', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),

          const SizedBox(width: 24,),

          Expanded(
            child: SubmitButton(
              onTap: onSubmit,
              label: "Terima",
            ),
          ),
        ],
        StatusPengajuan.ditolak || StatusPengajuan.diterima => [
            Expanded(child: SubmitButton(onTap: onSubmit, label: "Edit",))
        ],
      };
    } else {
      return switch(currentStatus){
        StatusPengajuan.menunggu =>
          [Expanded(child: SubmitButton(onTap: onSubmit, label: "Edit",))],
        StatusPengajuan.diterima || StatusPengajuan.ditolak =>
          [const Expanded(child: DisabledSubmitButton(label: "Edit",))],
      };
    }
  }
}
