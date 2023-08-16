import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';

class SimpleTextFieldDialog extends StatefulWidget {
  final String label;
  final void Function(String)? onSubmit;
  const SimpleTextFieldDialog({
    super.key,
    required this.label,
    required this.onSubmit,
  });

  @override
  State<SimpleTextFieldDialog> createState() => _SimpleTextFieldDialogState();
}

class _SimpleTextFieldDialogState extends State<SimpleTextFieldDialog> {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  String? textError;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        focusNode.requestFocus();
      }
    );

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              top: 16
            ),
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel_outlined,
                size: 28,
              )
            ),
          ),

          const SizedBox(height: 4,),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: CustomTextfield(
              controller: textController,
              label: widget.label,
              errorText: textError,
              focusNode: focusNode,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            child: SubmitButton(
              label: "Buat",
              onTap: widget.onSubmit == null ?
                  null :
                  (){
                    if (textController.text.isEmpty){
                      setState(() {
                        textError = "Data tidak boleh kosong";
                      });
                    }
                    else {
                      widget.onSubmit!(textController.text);
                    }
                  },
            ),
          )
        ],
      ),
    );
  }
}
