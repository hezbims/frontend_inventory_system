import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T?> values;
  final void Function(T?)? onValueChange;
  final String? errorText;
  final String nullText;
  const CustomDropdownMenu({
    super.key,
    required this.label,
    required this.value,
    required this.values,
    required this.onValueChange,
    required this.errorText,
    this.nullText = '--- Semua ---'
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label , style: labelStyle,),
        DropdownButtonFormField(
          items: values.map(
            (entry){
              return DropdownMenuItem(
                value: entry,
                child: Text(entry?.toString() ?? nullText),
              );
            }
          ).toList(),
          decoration: InputDecoration(
            errorText: errorText
          ),
          onChanged: onValueChange,
          value: value,
        ),
      ],
    );
  }
}
