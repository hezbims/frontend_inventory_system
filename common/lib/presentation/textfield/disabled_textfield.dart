import 'package:common/presentation/textfield/style/custom_input_decoration.dart';
import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class DisabledTextField extends StatelessWidget {
  final String label;
  final String value;
  final String? errorMessage;
  const DisabledTextField({
    required this.label,
    required this.value,
    required this.errorMessage,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label , style: labelStyle,),
        InputDecorator(
          decoration: CustomInputDecoration(
            errorText: errorMessage,
          ),
          child: Text(value),
        ),
      ],
    );
  }
}
