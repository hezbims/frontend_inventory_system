import 'package:common/domain/model/pengajuan.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/component/clock_field.dart';
import 'package:fitur_input_pengajuan/presentation/component/date_field.dart';
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

                CustomTextfield(
                    controller: provider.sectionController,
                    label: "Section",
                    errorText: null,
                ),
              ],
            );
          }
        ),
      )
    );
  }
}
