import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarangQuantityIncrementer extends StatelessWidget {
  final void Function() onDecrease;
  final void Function() onIncrease;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? errorMessage;
  final void Function(String) onSubmit;

  const BarangQuantityIncrementer({
    super.key,
    required this.onDecrease,
    required this.onIncrease,
    required this.controller,
    required this.errorMessage,
    required this.focusNode,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quantity" , style: labelStyle,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IconButton(
            //   icon: const Icon(Icons.remove_circle),
            //   onPressed: onDecrease,
            // ),

            IntrinsicWidth(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                onSubmitted: onSubmit,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            // IconButton(
            //   icon: const Icon(Icons.add_circle),
            //   onPressed: onIncrease,
            // ),
          ],
        ),

        if (errorMessage != null)
          Text(errorMessage! , style: const TextStyle(color: Colors.red),),
      ],
    );
  }
}
