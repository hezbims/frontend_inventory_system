import 'dart:math';
import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/provider/refresh_notifier.dart';
import 'package:common/response/api_response.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/dotted_border.dart';
import 'package:dependencies/flutter_dropzone.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_barang_by_csv/presentation/components/confirmation_submission_dialog.dart';
import 'package:fitur_input_barang_by_csv/presentation/components/error_submission_dialog.dart';
import 'package:fitur_input_barang_by_csv/presentation/provider/input_barang_by_csv_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvBody extends StatefulWidget {
  final InputBarangByCsvProvider provider;
  const InputBarangByCsvBody({
    super.key,
    required this.provider,
  });

  @override
  State<InputBarangByCsvBody> createState() => _InputBarangByCsvBodyState();
}

class _InputBarangByCsvBodyState extends State<InputBarangByCsvBody> {
  late final routeStateProvider = context.read<MyRouteStateProvider>();
  late final refreshNotifier = context.read<RefreshNotifier>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: max(
              24,
              (MediaQuery.of(context).size.width - 582) / 2
          ),
        ),
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: widget.provider.downloadTemplate,
                  child: const Text('Download Template')
              ),
              const Expanded(child: SizedBox())
            ],
          ),

          const SizedBox(height: 8,),

          Stack(
            children: [
              if (kIsWeb)
                Positioned.fill(
                    child: SizedBox(
                      child: DropzoneView(
                          mime: const ["text/csv"],
                          onHover: widget.provider.onHover,
                          onLeave: widget.provider.onLeaveHover,
                          onDropFile: (file) => widget.provider.handleDropFile(file),
                          onDropInvalid: widget.provider.onDropInvalid
                      ),
                    )
                ),

              InkWell(
                onTap: widget.provider.pickFile,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  dashPattern: const [12 , 12],
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    color: widget.provider.isHovering ?
                    const Color(0x4D656565) : null,
                    width: double.infinity,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.provider.choosenFile == null) ...[
                            const Icon(
                              Icons.add_circle_outline,
                              size: 36,
                            ),
                            const SizedBox(height: 16,),
                            const Text('Tarik atau pilih file .csv')
                          ]
                          else ...[
                            const Icon(
                              Icons.description_outlined,
                              size: 36,
                            ),
                            const SizedBox(height: 16,),
                            Text(
                                '${widget.provider.choosenFile?.name}'
                            )
                          ],
                        ]
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: widget.provider.overrideDataOnSubmit,
                            onChanged: widget.provider.onChangeOverrideDataOnSubmit
                        ),

                        const SizedBox(width: 2,),

                        const Expanded(
                          child: Text(
                            'Timpa data apabila nama atau kode barang sama',
                            style: TextStyle(
                                fontSize: 13
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    RichText(
                        text: const TextSpan(
                            text: '*',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                            ),
                            children: [
                              TextSpan(
                                text: ') jika ini tidak dicentang, '
                                    'maka transaksi akan dibatalkan '
                                    'apabila ada nama atau kode '
                                    'barang yang sama',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: CustomFontWeight.light,
                                ),
                              ),
                            ]
                        )
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24,),

              FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                ),
                onPressed: widget.provider.choosenFile != null &&
                    widget.provider.onSubmmit != null ? (){
                  ConfirmationSubmissionDialog(
                      context: context,
                      filename: widget.provider.choosenFile!.name,
                      isOverwriteByKodeBarang: widget.provider.overrideDataOnSubmit,
                      onConfirmPressed: widget.provider.onSubmmit!
                  ).show();
                } : null,
                child:
                widget.provider.uploadByCsvResponse is ApiResponseLoading ?
                const CircularProgressIndicator() :
                const Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.provider.addListener(() {
      if (widget.provider.errors != null){
        final errors = widget.provider.errors!;
        widget.provider.onDoneShowErrors();

        showDialog(
          context: context,
          builder: (context){
            return ErrorSubmissionDialog(
              errors: errors.entries.toList(growable: false),
              insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).phoneWidthPotraitPadding,
                vertical: MediaQuery.of(context).phoneHeightLandscapePadding,
              ),
            );
          },
        );
      }
      else if (widget.provider.uploadByCsvResponse is ApiResponseSuccess){
        Fluttertoast.showToast(
          msg: "Berhasil mensubmit CSV!" ,
          timeInSecForIosWeb: 4
        );
        refreshNotifier.notifyListeners();

        routeStateProvider.setRouteState(
          RouteLihatStockBarangState(),
        );
      }
    });

  }
}
