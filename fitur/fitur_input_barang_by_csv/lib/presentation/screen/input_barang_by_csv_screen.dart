
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_barang_by_csv/presentation/components/input_barang_by_csv_body.dart';
import 'package:fitur_input_barang_by_csv/presentation/provider/input_barang_by_csv_provider.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvScreen extends StatelessWidget {
  const InputBarangByCsvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<InputBarangByCsvProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Input Barang by CSV'),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        body: Consumer<InputBarangByCsvProvider>(
            builder: (context , provider , child) {
              return InputBarangByCsvBody(provider: provider);
            }
        ),
      ),
    );
  }
}
