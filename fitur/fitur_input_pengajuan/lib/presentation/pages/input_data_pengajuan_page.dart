import 'package:common/data/repository/fake_lihat_stock_barang_repository.dart';
import 'package:common/domain/model/group.dart';
import 'package:common/domain/model/pengajuan.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/clock_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/barang_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/date_field.dart';
import 'package:fitur_input_pengajuan/presentation/provider/input_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class InputDataPengajuanPage extends StatelessWidget {
  const InputDataPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Pengajuan? initialData;
    try {
      initialData = ModalRoute.of(context)?.settings.arguments as Pengajuan;
    } catch (_) {}
    return ChangeNotifierProvider(
      create : (context) => InputPengajuanProvider(
        initialData: initialData,
        barangRepository: FakeLihatStockBarangRepository(),
      ),
      child : Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text("Form Input Transaksi"),
          leading: const BackButton(),
        ),
        bottomNavigationBar: SubmitCard(
          onTap: (){},
        ),
        body: Consumer<InputPengajuanProvider>(
          builder: (context , provider , child) {
            return ListView(
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

                CustomTextfield(
                  controller: provider.tipePengajuanController,
                  label: "Tipe pengajuan",
                  errorText: provider.tipePengajuanError
                ),

                const VerticalFormSpacing(),

                CustomTextfield(
                    controller: provider.namaController,
                    label: "Nama",
                    errorText: provider.namaError,
                ),

                const VerticalFormSpacing(),

                DropDownPageChooser(
                  label: "Group",
                  value: provider.group?.namaGroup ?? "",
                  errorMessage: provider.groupError,
                  onTap: () async {
                      final groupPicked = await Navigator.of(context).pushNamed(
                        Routes.fiturPilihGroupRoute,
                      );
                      if (groupPicked is Group){
                        provider.onChangeGroup(groupPicked);
                      }
                  }
                ),

                const VerticalFormSpacing(),

                BarangField(listBarangTransaksi: provider.listBarangTransaksi),
              ],
            );
          }
        ),
      )
    );
  }
}
