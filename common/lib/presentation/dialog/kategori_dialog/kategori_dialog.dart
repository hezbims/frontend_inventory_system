import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog_provider.dart';
import 'package:common/presentation/dialog/simple_text_field_dialog.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';

class BuatKategoriDialog extends StatelessWidget {
  const BuatKategoriDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create : (context) => GetIt.I.get<KategoriDialogProvider>(),
      child: Consumer<KategoriDialogProvider>(
        builder: (context , provider , child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (provider.submitResponse is ApiResponseSuccess) {
              Navigator.of(context).pop(true);
            }
          });

          return SimpleTextFieldDialog(
            label: "Kategori",
            onSubmit: provider.submitResponse is ApiResponseLoading ?
              null : provider.submit
          );
        }
      ),
    );
  }
}
