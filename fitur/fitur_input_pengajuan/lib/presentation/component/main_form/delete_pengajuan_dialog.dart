import 'package:common/constant/themes/theme_color.dart';
import 'package:dependencies/rflutter_alert.dart';
import 'package:flutter/material.dart';

class DeletePengajuanDialog extends Alert {
  DeletePengajuanDialog({
    required super.context
  }) : super(
    type: AlertType.warning,
    desc: 'Apakah anda yakin ingin menghapus pengajuan ini?',
    buttons: [
      DialogButton(
        color: Colors.red,
        child: const Text('Tidak' , style: TextStyle(color: Colors.white),),
        onPressed: () => Navigator.of(context).pop(false)
      ),

      DialogButton(
        color: primaryColor,
        child: const Text('Ya' , style: TextStyle(color: Colors.white),),
        onPressed: () => Navigator.of(context).pop(true)
      ),
    ]
  );
}