import 'package:common/presentation/dialog/simple_text_field_dialog.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/provider.dart';
import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_group/buat_group_provider.dart';
import 'package:flutter/material.dart';

Future<dynamic> showBuatGroupDialog({
  required BuildContext context,
  required bool isPemasok,
}){
  return showDialog(
    context: context,
    builder: (context){
      return _BuatGroupDialog(isPemasok: isPemasok);
    }
  );
}

class _BuatGroupDialog extends StatelessWidget {
  final bool isPemasok;
  const _BuatGroupDialog({required this.isPemasok});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BuatGroupProvider(
        isPemasok: isPemasok,
        repository: PengajuRepositoryImpl(),
      ),
      child: Consumer<BuatGroupProvider>(
        builder: (context , provider , child) {
          if (provider.submitResponse is ApiResponseSuccess){
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pop(true),
            );
          }
          return SimpleTextFieldDialog(
            label: "Nama ${isPemasok ? "pemasok" : "group"}",
            onSubmit: provider.submitResponse is ApiResponseLoading ?
              null : provider.submit
          );
        }
      ),
    );
  }
}
