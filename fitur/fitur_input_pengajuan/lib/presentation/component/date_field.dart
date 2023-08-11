import 'package:common/presentation/textfield/style/custom_input_decoration.dart';
import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:common/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final String? errorMessage;
  final DateTime value;
  final void Function(DateTime) onValueChange;
  const DateField({
    super.key,
    required this.errorMessage,
    required this.value,
    required this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tanggal",
          style: labelStyle,
        ),
        GestureDetector(
          onTap: () async {
            final currentDate = DateTime.now();
            final newValue = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: currentDate.add(const Duration(days: 365 * -10)),
              lastDate: currentDate.add(const Duration(days: 365 * 10)),
            );

            if (newValue != null){
              onValueChange(newValue);
            }
          },
          child: InputDecorator(
            decoration: CustomInputDecoration(
              errorText: errorMessage,
              suffixIcon: const Icon(Icons.date_range),
            ),
            child: Text(
              IntlFormatter.dateTimeToString(value)
            ),
          ),
        ),
      ],
    );
  }
}
