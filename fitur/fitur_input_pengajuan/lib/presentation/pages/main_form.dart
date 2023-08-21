import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/clock_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/barang_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/date_field.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/input_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class MainForm extends StatelessWidget {
  final Pengajuan initialData;
  const MainForm({
    super.key,
    required this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create : (context) => InputPengajuanProvider(
          initialData: initialData,
        ),
        child : Consumer<InputPengajuanProvider>(
            builder: (context , provider , child) {
              return Scaffold(
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  title: const Text("Form Input Transaksi"),
                  leading: const BackButton(),
                ),
                bottomNavigationBar: SubmitCard(
                  onTap: (){},
                ),
                body: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 36
                  ),
                  children: [
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

                    const VerticalFormSpacing(),

                    CustomDropdownMenu(
                        label: "Tipe pengajuan",
                        value: provider.currentTipePengajuan,
                        values: provider.tipePengajuanList,
                        onValueChange: provider.onTipePengajuanChange,
                        errorText: provider.tipePengajuanError
                    ),


                    const VerticalFormSpacing(),

                    if (provider.isPemasukan == true) ...[
                      DropdownPageChooser(
                          label: "Nama Pemasok",
                          value: provider.pemasok?.nama ?? "",
                          errorMessage: provider.pemasokError,
                          onTap: () async {
                            final pemasokPicked = await Navigator.of(context).pushNamed(
                              Routes.fiturPilihGroupRoute,
                              arguments: 1,
                            );
                            if (pemasokPicked is Pengaju){
                              provider.onChangePemasok(pemasokPicked);
                            }
                          }
                      ),
                      const VerticalFormSpacing(),
                    ]
                    else if (provider.isPemasukan == false) ...[
                      DropdownPageChooser(
                          label: "Group",
                          value: provider.group?.nama ?? "",
                          errorMessage: provider.groupError,
                          onTap: () async {
                            final groupPicked = await Navigator.of(context).pushNamed(
                              Routes.fiturPilihGroupRoute,
                              arguments: 0,
                            );
                            if (groupPicked is Pengaju){
                              provider.onChangeGroup(groupPicked);
                            }
                          }
                      ),
                      const VerticalFormSpacing(),
                    ],

                    BarangField(listBarangTransaksi: provider.listBarangTransaksi),
                  ],
                ),
              );
            }
        )
    );
  }
}
