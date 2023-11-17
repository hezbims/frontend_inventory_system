
import 'package:dependencies/file_picker.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_barang_by_csv/presentation/input_barang_by_csv_provider.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvPage extends StatelessWidget {
  const InputBarangByCsvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InputBarangByCsvProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Input Barang by CSV'),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: ListView(
                children: [
                  const InkWell(
                    child: Text(
                        'Download Template'
                    ),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 582
                    ),
                    child: InkWell(
                      onTap: context.read<InputBarangByCsvProvider>().pickFile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Selector<InputBarangByCsvProvider , PlatformFile?>(
                          selector: (context , provider) => provider.choosenFile,
                          shouldRebuild: (prev , next) => prev?.path != next?.path,
                          builder: (context , file , child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (file == null) ...[
                                  const Icon(Icons.add_box_outlined),
                                  const Text('Tarik atau Pilih File .csv')
                                ]
                                else ...[
                                  const Icon(Icons.description_outlined),
                                  Text(file.name)
                                ],
                              ]
                            );
                          }
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
