import 'package:common/constant/themes/custom_sizing.dart';
import 'package:common/constant/themes/theme_color.dart';
import 'package:dependencies/rflutter_alert.dart';
import 'package:flutter/material.dart';

class ConfirmationSubmissionDialog extends Alert {
  ConfirmationSubmissionDialog({
    required super.context,
    required String filename,
    required bool isOverwriteByKodeBarang,
    required void Function() onConfirmPressed,
  }) : super(
    type: AlertType.warning,
    desc: "${
        isOverwriteByKodeBarang ?
          "Data dengan kode barang yang sama akan ditimpa. " :
          ""
        }"
        "Apakah anda yakin ingin mensubmit file '$filename' ?",
    buttons: [
      DialogButton(
        color: Colors.white,
        border: Border.all(width: 0.2),
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Tidak" , style: TextStyle(color: Colors.black),),
      ),
      DialogButton(
        color: primaryColor,
        onPressed: (){
          onConfirmPressed();
          Navigator.of(context).pop();
        },
        child: const Text("Ya" , style: TextStyle(color: Colors.white),),
      )
    ],
    style: const AlertStyle(
      constraints: BoxConstraints(
        maxWidth: CustomSizing.maxPhoneLandscapeWidth
      ),
      descStyle: TextStyle(
        fontSize: 16,
      )
    )
  );
}

