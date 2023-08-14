import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:dependencies/google_fonts.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/buat_group_provider.dart';
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
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 42,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Buat Group Baru",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 16,),

                      CustomTextfield(
                        controller: provider.sectionController,
                        label: "Section",
                        errorText: provider.sectionError
                      ),

                      const SizedBox(height: 16,),

                      CustomTextfield(
                          controller: provider.groupController,
                          label: "Nama group baru",
                          errorText: provider.groupError
                      ),

                      const SizedBox(height: 16,),

                      SubmitButton(onTap: provider.submit,),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
