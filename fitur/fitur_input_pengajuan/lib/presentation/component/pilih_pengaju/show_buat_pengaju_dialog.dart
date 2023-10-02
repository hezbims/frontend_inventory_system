import 'package:common/presentation/dialog/simple_text_field_dialog.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/dependency_setup/buat_pengaju_dialog_dependency_setup.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/buat_pengaju_provider.dart';
import 'package:flutter/material.dart';

Future<dynamic> showBuatPengajuDialog({
  required BuildContext context,
  required bool isPemasok,
}){
  return showDialog(
    context: context,
    builder: (context){
      return BuatPengajuDialogDependencySetup(isPemasok: isPemasok);
    }
  );
}

class BuatPengajuBaruDialog extends StatelessWidget {
  const BuatPengajuBaruDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<BuatPengajuProvider>(),
      child: Consumer<BuatPengajuProvider>(
        builder: (context , provider , child) {
          if (provider.submitResponse is ApiResponseSuccess){
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pop(true),
            );
          }
          return SimpleTextFieldDialog(
            label: "Nama ${provider.isPemasok ? "pemasok" : "group"}",
            onSubmit: provider.submitResponse is ApiResponseLoading ?
              null : provider.submit
          );
        }
      ),
    );
  }
}
