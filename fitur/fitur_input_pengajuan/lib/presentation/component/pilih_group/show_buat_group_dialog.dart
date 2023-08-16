import 'package:common/presentation/dialog/simple_text_field_dialog.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_group/buat_group_provider.dart';
import 'package:flutter/material.dart';

Future<dynamic> showBuatGroupDialog(BuildContext context){
  return showDialog(
    context: context,
    builder: (context){
      return const _BuatGroupDialog();
    }
  );
}

class _BuatGroupDialog extends StatelessWidget {
  const _BuatGroupDialog();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BuatGroupProvider(),
      child: Consumer<BuatGroupProvider>(
        builder: (context , provider , child) {
          return SimpleTextFieldDialog(
            label: "Nama group",
            onSubmit: (result){

            }
          );
        }
      ),
    );
  }
}
